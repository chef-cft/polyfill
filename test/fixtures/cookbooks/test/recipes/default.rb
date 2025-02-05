# install automate standalone
chef_automatev2 'automatev2.chefstack.local' do
  config <<~EOS
    [global.v1]
      fqdn = "chef-automate.example.com"
  EOS
  products %w(automate)
  accept_license true
end

# run polyfill
include_recipe 'polyfill::default'
