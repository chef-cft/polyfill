describe file('/usr/local/bin/chef-automate') do
  it { should_not exist }
end

bin_path = if os.debian?
             '/bin/chef-automate'
           else
             '/usr/bin/chef-automate'
           end

describe file(bin_path) do
  it { should exist }
end

describe command('chef-automate version') do
  its('exit_status') { should eq 0 }
end

describe service('chef-automate') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end
