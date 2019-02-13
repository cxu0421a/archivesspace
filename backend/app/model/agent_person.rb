require_relative 'name_person'

class AgentPerson < Sequel::Model(:agent_person)

  include ASModel
  corresponds_to JSONModel(:agent_person)

  include ExternalDocuments
  include AgentManager::Mixin
  include RecordableCataloging
  include Notes
  include Publishable
  include AutoGenerator
  include Assessments::LinkedAgent

  register_agent_type(:jsonmodel => :agent_person,
                      :name_type => :name_person,
                      :name_model => NamePerson)

  # This did not work... but it is the idea of what needs to happen - for some reason
  # it couldn't find the AgentPerson. the data generated is
  # disp_name {"is_display_name"=>true, "rules"=>"local", "authorized"=>true, "name_order"=>"inverted", "primary_name"=>"someone else too", "sort_name_auto_generate"=>true, "use_dates"=>[]}
  # result "someone else too"
  # So the data looks right but the error is
  # D, [2019-02-14T13:54:26.416856 #21313] DEBUG -- : Thread-2012: Responded with [404, {"Content-Type"=>"application/json", "Cache-Control"=>"private, must-revalidate, max-age=0", "Content-Length"=>"34"}, ["{\"error\":\"AgentPerson not found\"}\n"]]... in 80ms
  # auto_generate :property => :slug,
  #               :only_on_create => true,
  #               :generator => proc  { |json|
  #                 result = ""
  #                 disp_name = json['names'].find {|name| name['is_display_name']}
  #
  #                 This did not work... but it is the idea of what needs to happen
  #                 if disp_name["name_order"] === "inverted"
  #                   result << disp_name["primary_name"] if disp_name["primary_name"]
  #                   result << ", #{disp_name["rest_of_name"]}" if disp_name["rest_of_name"]
  #                 elsif disp_name["name_order"] === "direct"
  #                   result << disp_name["rest_of_name"] if disp_name["rest_of_name"]
  #                   result << " #{disp_name["primary_name"]}" if disp_name["primary_name"]
  #                 else
  #                   result << disp_name["primary_name"]
  #                 end
  #               },
  #               :only_if => proc { |json| json["is_slug_auto"] && AppConfig[:use_human_readable_URLs] }


end
