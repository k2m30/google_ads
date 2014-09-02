class Country < ActiveRecord::Base
  has_many :ads, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def self.refresh
    begin
      unless ENV['HEADLESS'].nil?
        require 'headless'
        headless = Headless.new
        headless.start
        logger.fatal('headless started')
      end
      Country.all.each do |country|
        begin
          # if ENV['BROWSER'].nil? || ENV['BROWSER'] == 'firefox'
          profile = Selenium::WebDriver::Firefox::Profile.new
          profile.proxy = Selenium::WebDriver::Proxy.new socks: country.proxy
          b = Watir::Browser.new :ff, profile: profile
          logger.fatal('firefox started')
          # else
          #   switches = ["--proxy-server=\"socks5://#{country.proxy}\""]
          #   b = Watir::Browser.new :chrome, switches: switches
          # end
          b.goto 'google.com'
          logger.fatal('google visited')
          country.ads.each { |ad| ad.check(b) }
        ensure
          b.close if b.present?
        end
      end
    ensure
      if ENV['HEADLESS']
        headless.destroy
      end
    end

  end
end
