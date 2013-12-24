FactoryGirl.define do
  factory :member, :class => Kahuna::Member do
    role { %w(web lb ns db es proxy).sample }
    sequence(:name) { |n| "#{role}#{n}.example.com" }
    sequence(:address) { |n| "10.10.10.#{n}" }
    initialize_with { new("#{name} #{address} #{role}")}
  end
end
