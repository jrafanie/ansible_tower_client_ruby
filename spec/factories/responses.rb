FactoryGirl.define do
  factory :response_collection, :class => "Hash" do
    count    2
    "next"   ""
    previous ""
    klass    ""
    results  { count.times.collect { build(:response_instance, :klass => klass) } }

    initialize_with { AnsibleTowerClient::FactoryHelper.stringify_attribute_keys(attributes) }
  end

  factory :response_instance, :class => "Hash" do
    sequence(:id)
    klass      ""
    type       { AnsibleTowerClient::FactoryHelper.underscore_string(klass.namespace.last) }
    name       { "#{type}-#{id}" }
    url        { "/api/v1/#{klass.endpoint}/#{id}/" }

    initialize_with { AnsibleTowerClient::FactoryHelper.stringify_attribute_keys(attributes) }

    trait(:description) { sequence(:description) { |n| "description_#{n}" } }
    trait(:extra_vars)  { extra_vars "lots of options" }
    trait(:instance_id) { instance_id SecureRandom.uuid }
  end
end
