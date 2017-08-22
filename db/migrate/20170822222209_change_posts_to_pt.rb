class ChangePostsToPt < ActiveRecord::Migration[5.0]
  def change
    execute("UPDATE spina_page_translations SET locale = 'pt';
            UPDATE spina_line_translations SET locale = 'pt';
            UPDATE spina_text_translations SET locale = 'pt';
            ")
  end
end
