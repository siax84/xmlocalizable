class Synchronization < ApplicationRecord
  
  has_many :fields, dependent: :destroy
  has_many :mappings, dependent: :destroy
  
  validates_presence_of :name, :source_platform, :target_platform
  
  before_save :save_android_fields, :save_ios_fields
  after_save :save_mapping
  
  def save_android_fields
   document = (source_platform == 'Android' ? source_document : target_document)
   unless document.blank?
      xml_doc = Nokogiri::XML document
      xml_doc.xpath("//string").each_with_index do |string, index|
        field = Field.find_or_initialize_by(name: string[:name], platform: 'Android', synchronization_id: self.id)
        field.is_comment = string.content.starts_with?('<!--')
        field.line = index
        field.field_value = string.content
        field.save
      end
    end
  end
  
  def save_ios_fields
    document = (source_platform == 'iOS' ? source_document : target_document)
    unless document.blank?
      line_count = 0
      is_comment = false
      document.each_line do |line|
        if line.include?('" = "')
          key_value = split_line(line, '" = "')
        elsif line.include?('"="')
          key_value = split_line(line, '"="')
        elsif line.include?('"  = "')
          key_value = split_line(line, '"  = "')
        elsif line.include?('" =  "')
          key_value = split_line(line, '" =  "')
        elsif line.include?('"  =  "')
          key_value = split_line(line, '"  =  "')
        else
          key_value = '""="";'
          is_comment = true # An empty line is treated as a comment line          
        end
      key = get_clean_key(key_value)
      value = get_clean_value(key_value)
      field = Field.find_or_initialize_by(line: line_count, name: key, platform: 'iOS', synchronization_id: self.id)
      field.is_comment = line.starts_with?('/*', '*/', '//') || is_comment
      field.field_value = value
      field.line = line_count
      field.save if field.changed?
      line_count += 1
      end
    end
  end
  
  def save_mapping
    source_fields.each do |source|
      mapping = Mapping.find_or_initialize_by(source_field_id: source.id, synchronization_id: self.id)
      mapping.common_value = source.field_value
      mapping.save validate: false if mapping.changed?
    end
  end
  
  def source_fields
    self.fields.where(:platform => self.source_platform)
  end
  
  def target_fields
    self.fields.where(:platform => self.target_platform)
  end
  
  private
  
  def split_line(line,pattern)
    line.split(pattern)
  end
  
  def get_clean_key(key_value)
    key = key_value[0].delete_prefix('"') if key_value[0]
  end  
  
  def get_clean_value(key_value)
    value = key_value[1].chomp('"').chomp('').delete_suffix('";') if key_value[1]
  end  
  
end
