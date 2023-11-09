# https://docs.ruby-lang.org/en/3.2/JSON.html#module-JSON-label-JSON+Additions

require 'json'

JSON.create_id = 'resource_type'

data_source = <<JSON
[
  {
    "resource_type": "Legend",
    "data": { "email": "jim@weirich.com", "fullname": "Jim Weirich" }
  },
  {
    "resource_type": "Legend",
    "data": { "email": "chris@seaton.com", "fullname": "Chris Seaton" }
  }
]
JSON

data_source2 = <<JSON
[
  {
    "data": { "email": "jim@weirich.com", "fullname": "Jim Weirich" }
  }
]
JSON

class Legend
  def initialize(json)
    @email = json['email']
    @fullname = json['fullname']
  end

  def self.json_create(legend)
    new(legend['data'])
  end
end

pp JSON.parse(data_source, create_additions: true)
# [#<Legend:0x00007f6e6b46d008 @email="jim@weirich.com", @fullname="Jim Weirich">,
# #<Legend:0x00007f6e6b46ca18 @email="chris@seaton.com", @fullname="Chris Seaton">]

pp JSON.parse(data_source2, create_additions: true)
# [{"data"=>{"email"=>"jim@weirich.com", "fullname"=>"Jim Weirich"}}]