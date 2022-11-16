OLD_TAB_LABELS = ['National resources', 'Global publications', 'Governance documents']
NEW_TAB_LABELS = ['National use', 'Global and general', 'BIP governance']
NEW_TAGS = [
  { old: 'Biodiversity Indicator' },
  { old: 'Ecosystem services' },
  { old: 'Global indicator' },
  { old: 'Indicator development' },
  { old: 'Methodology', new: 'Indicator methods' },
  { old: 'National use' },
  { old: 'NBSAPs' },
  { old: 'Strategic Plan', new: 'Target coverage' },
  { new: 'Tools' }
]

class UpdateTagsAndTabsForCmsResources < ActiveRecord::Migration
  def up
    update_tab_labels(NEW_TAB_LABELS)
    update_tags
  end

  def down
    update_tab_labels(OLD_TAB_LABELS)

    # Resets labels of remaining tags but does not recreate tags that were deleted
    rollback_tag_labels
  end

  private

  def update_tab_labels(labels)
    Comfy::Cms::Page.find_by_label("Resources").children.each_with_index do |page, index|
      page.update(label: labels[index])
    end
  end

  def update_tags
    Tag.all.each do |tag|
      new_tag = NEW_TAGS.select { |t| t[:old] == tag[:name] }.first

      if new_tag
        tag.update(name: new_tag[:new]) if new_tag[:new]
      else
        tag.destroy
      end
    end
  end

  def rollback_tag_labels
    Tag.all.each do |tag|
      old_tag = NEW_TAGS.select { |t| t[:new] == tag[:name] }.first

      tag.update(name: old_tag[:old]) if old_tag && old_tag[:old]
    end
  end
end
