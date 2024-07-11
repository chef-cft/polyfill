describe service('chef-automate') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe file('/hab/pkgs/chef/automate-ui/2.0.0/20240305055235/dist/assets/chef-ui-library/chef/sandbox.html') do
  it { should_not exist }
end

describe file('/hab/pkgs/chef/automate-ui/2.0.0/20240305055235/dist/assets/chef-ui-library/collection/sandbox.html') do
  it { should_not exist }
end

describe file('/var/log/chef-quarantine-polyfill') do
  it { should exist }
end
