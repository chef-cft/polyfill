# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
#
# Author:: Corey Hemminger
# Cookbook:: polyfill
# Resource:: remediation
#
# Copyright:: 2024, Progress Software
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
unified_mode true

description 'Remediate Polyfill Vulnerability'

action :run do
  description 'run polyfill remediation'

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
end
