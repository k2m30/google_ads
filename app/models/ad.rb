class Ad < ActiveRecord::Base
  belongs_to :country
  
  def check(browser)
    browser.text_field(name: 'q').set body
    browser.send_keys :enter
    browser.link(id: 'pnnext').wait_until_present
    target_text = 'intellectsoft'
    result = (browser.div(id: 'tads').present? && browser.div(id: 'tads').text.include?(target_text)) || (browser.div(id: 'mbEnd').present? && browser.div(id: 'mbEnd').text.include?(target_text))
    seo = browser.div(id: 'res').text.include?(target_text)

    update(passed: result, seo: seo) if changed?

  end
end
