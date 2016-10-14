require 'open-uri'
require 'nokogiri'

# Create first gympass user
#

user = User.create!(name: 'Xará',
                    email: 'adriano@gympass.com',
                    type_user: '0',
                    work_address: 'Sao Paulo',
                    password: "123123",
                    password_confirmation: "123123",
                    admin: "true"
                    )

page = Nokogiri::HTML(open("https://www.gympass.com/negocios/"))

page.css('div.rec_list_s').each do |item|
  Gym.create(user: user,
             name: item.css('h3').text,
             address: item.css("meta[itemprop='address']").first.attributes.values[1].value,
             open_time: "6",
             close_time: "23"
             )
end
