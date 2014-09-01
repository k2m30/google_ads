require 'watir-webdriver'

class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  def refresh
    if ENV['HEADLESS']
      require 'headless'
      headless = Headless.new
      headless.start
    end
    @ads = Ad.all
    begin
      Country.all.each do |country|
        begin
          if ENV['BROWSER'] == 'firefox'
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile.proxy = Selenium::WebDriver::Proxy.new socks: country.proxy
            b = Watir::Browser.new :ff, profile: profile
          else
            switches = ["--proxy-server=\"socks5://#{country.proxy}\""]
            b = Watir::Browser.new :chrome, switches: switches
          end
          b.goto 'google.com'
          country.ads.each do |ad|
            b.text_field(name: 'q').set ad.body
            b.send_keys :enter
            b.link(id: 'pnnext').wait_until_present
            target_text = 'intellectsoft'
            result = (b.div(id: 'tads').present? && b.div(id: 'tads').text.include?(target_text)) || (b.div(id: 'mbEnd').present? && b.div(id: 'mbEnd').text.include?(target_text))
            seo = b.div(id: 'res').text.include?(target_text)

            ad.update(passed: result, seo: seo) if ad.changed?
          end
        ensure
          b.close
        end
      end
    ensure
      if ENV['HEADLESS']
        headless.destroy
      end
    end

    render :status
  end

  def status
    @ads = Ad.all.includes(:country).order('country_id', :body)
  end

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ad
    @ad = Ad.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_params
    params.require(:ad).permit(:body)
  end

  def ask_google(proxy, queries)
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile.proxy = Selenium::WebDriver::Proxy.new socks: proxy
    b = Watir::Browser.new :ff, profile: profile

    b.goto 'google.com'
    queries.each do |query|
      b.text_field(name: 'q').set query
      b.send_keys :enter
      b.link(id: 'pnnext').wait_until_present
      result = b.text.include? 'intellectsoft.co.uk'
      p query << ' : ' << result.to_s
    end
    # b.close
  end

end
