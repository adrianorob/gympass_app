require 'open-uri'
require 'nokogiri'

# Create first gympass user
# user = User.create!(name: 'Xará',
#                     email: 'adriano@gympass.com',
#                     type_user: '0',
#                     work_address: 'Sao Paulo',
#                     password: "123123",
#                     password_confirmation: "123123",
#                     admin: "true"
#                     )

# Seed academias sao paulo
page = Nokogiri::HTML(open("https://www.gympass.com/academias/em/sp/sao-paulo"))
page.css('div.rec_list_s').each do |item|
  gym = Gym.create(user: User.first,
                   name: item.css('h3').text,
                   address: item.css("meta[itemprop='address']").first.attributes.values[1].value,
                   open_time: "6",
                   close_time: "23"
                   )
  puts "Gym #{gym.name} created"
end

# Seed academias Ribeirao Preto
page = Nokogiri::HTML(open("https://www.gympass.com/academias/em/sp/ribeirao-preto"))
page.css('div.rec_list_s').each do |item|
  gym = Gym.create(user: User.first,
                   name: item.css('h3').text,
                   address: item.css("meta[itemprop='address']").first.attributes.values[1].value,
                   open_time: "6",
                   close_time: "23"
                   )
  puts "Gym #{gym.name} created"
end

# Seed academias Rio de Janeiro
page = Nokogiri::HTML(open("https://www.gympass.com/academias/em/rj/rio-de-janeiro"))
page.css('div.rec_list_s').each do |item|
  gym = Gym.create(user: User.first,
                   name: item.css('h3').text,
                   address: item.css("meta[itemprop='address']").first.attributes.values[1].value,
                   open_time: "6",
                   close_time: "23"
                   )
  puts "Gym #{gym.name} created"
end
