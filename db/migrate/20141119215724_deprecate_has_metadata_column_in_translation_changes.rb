# Copyright 2014 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

class DeprecateHasMetadataColumnInTranslationChanges < ActiveRecord::Migration
  def up
    # Create
    add_column :translation_changes, :diff, :text

    # Populate
    TranslationChange.find_each do |obj|
      obj.update_columns diff: JSON.parse(obj.metadata)["diff"]
    end

    # Remove the metadata column
    remove_column :translation_changes, :metadata
  end
end
