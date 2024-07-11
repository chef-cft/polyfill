automate_dir = '/hab/pkgs/chef/automate-ui/2.0.0'
deleted_files = []

if ::File.exist?(automate_dir)
  Find.find(automate_dir) do |path|
    if ::File.basename(path) == 'sandbox.html'
      file path do
        action :delete
      end
      deleted_files.push(path)
    end
  end

  file '/var/log/chef-quarantine-polyfill' do
    content deleted_files.join("\n")
    action :create
    not_if { deleted_files.empty? }
  end
end
