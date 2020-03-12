module PayjpMock
  def self.prepare_customer_information # Payjp::Customerのレスポンスモック
    {
      "id": "cus_300daf34a03db2f7fbe88b3ba8b2",
      "cards": {
        "count":1,
        "data":[{
          "id":"car_f3193bef35142a83deb6c249718e",
          "address_city":nil,
          "address_line1":nil,
          "address_line2":nil,
          "address_state":nil,
          "address_zip":nil,
          "address_zip_check":"unchecked",
          "brand":"Discover",
          "country":nil,
          "customer":"cus_300daf34a03db2f7fbe88b3ba8b2",
          "cvc_check":"unchecked",
          "exp_month":06,
          "exp_year":2022,
          "fingerprint":"3dca58d6aeb4358b288b4a5fc69e677d",
          "last4":"9424",
          "livemode":false,
          "metadata":{},
          "name":nil,
          "object":"card"
          }],
          "has_more":false,
          "object":"list",
        },
      "default_card": "	car_f3193bef35142a83deb6c249718e",
      "description": nil,
      "email": nil,
      "livemode": false,
      "metadata": {},
      "object": "customer",
      "subscriptions": {
        "count":0,
        "data":[],
        "has_more":false,
        "object":"list",
      }
    }
  end
end