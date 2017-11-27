# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171127221113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "area_de_interesses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "client_solicitations", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_client_solicitations_on_project_id", using: :btree
    t.index ["user_id"], name: "index_client_solicitations_on_user_id", using: :btree
  end

  create_table "curso_superiors", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invite_emails", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "to_email"
    t.string   "token"
    t.integer  "project_id"
    t.boolean  "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_invite_emails_on_project_id", using: :btree
    t.index ["user_id"], name: "index_invite_emails_on_user_id", using: :btree
  end

  create_table "landing_quizzes", force: :cascade do |t|
    t.string   "quem"
    t.string   "curso"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_solicitations", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "message"
    t.index ["project_id"], name: "index_member_solicitations_on_project_id", using: :btree
    t.index ["user_id"], name: "index_member_solicitations_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "read",        default: false
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.decimal  "order_amount"
    t.string   "currency"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "status"
    t.index ["project_id"], name: "index_payments_on_project_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

  create_table "project_area_de_interesses", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "area_de_interesse_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["area_de_interesse_id"], name: "index_project_area_de_interesses_on_area_de_interesse_id", using: :btree
    t.index ["project_id"], name: "index_project_area_de_interesses_on_project_id", using: :btree
  end

  create_table "project_events", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["project_id"], name: "index_project_events_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_events_on_user_id", using: :btree
  end

  create_table "project_invitations", force: :cascade do |t|
    t.integer  "user_from_id"
    t.integer  "user_to_id"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["project_id"], name: "index_project_invitations_on_project_id", using: :btree
    t.index ["user_from_id"], name: "index_project_invitations_on_user_from_id", using: :btree
    t.index ["user_to_id"], name: "index_project_invitations_on_user_to_id", using: :btree
  end

  create_table "project_users", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "first_timeline_view", default: false
    t.index ["project_id"], name: "index_project_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_users_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "objective"
    t.text     "description"
    t.boolean  "nat_privada"
    t.boolean  "nat_publica"
    t.boolean  "nat_ong"
    t.string   "target_audience"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "client_id"
    t.boolean  "started"
    t.boolean  "deleted",         default: false
    t.string   "imgurl"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "spina_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.text     "preferences"
    t.string   "logo"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "kvk_identifier"
    t.string   "vat_identifier"
    t.boolean  "robots_allowed", default: false
  end

  create_table "spina_attachment_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_attachment_collections_attachments", force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_count_page_views", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_layout_parts", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "layout_partable_id"
    t.string   "layout_partable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "spina_line_translations", force: :cascade do |t|
    t.integer  "spina_line_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "content"
    t.index ["locale"], name: "index_spina_line_translations_on_locale", using: :btree
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id", using: :btree
  end

  create_table "spina_lines", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_navigation_items", force: :cascade do |t|
    t.integer  "page_id",                   null: false
    t.integer  "navigation_id",             null: false
    t.integer  "position",      default: 0, null: false
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true, using: :btree
  end

  create_table "spina_navigations", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "label",                          null: false
    t.boolean  "auto_add_pages", default: false, null: false
    t.integer  "position",       default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true, using: :btree
  end

  create_table "spina_options", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_page_parts", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "page_id"
    t.integer  "page_partable_id"
    t.string   "page_partable_type"
  end

  create_table "spina_page_translations", force: :cascade do |t|
    t.integer  "spina_page_id",     null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.string   "menu_title"
    t.string   "description"
    t.string   "seo_title"
    t.string   "materialized_path"
    t.index ["locale"], name: "index_spina_page_translations_on_locale", using: :btree
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id", using: :btree
  end

  create_table "spina_pages", force: :cascade do |t|
    t.boolean  "show_in_menu",        default: true
    t.string   "slug"
    t.boolean  "deletable",           default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.boolean  "skip_to_first_child", default: false
    t.string   "view_template"
    t.string   "layout_template"
    t.boolean  "draft",               default: false
    t.string   "link_url"
    t.string   "ancestry"
    t.integer  "position"
    t.boolean  "active",              default: true
  end

  create_table "spina_photo_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_photo_collections_photos", force: :cascade do |t|
    t.integer "photo_collection_id"
    t.integer "photo_id"
    t.integer "position"
  end

  create_table "spina_photos", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_rewrite_rules", force: :cascade do |t|
    t.string   "old_path"
    t.string   "new_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_structure_items", force: :cascade do |t|
    t.integer  "structure_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id", using: :btree
  end

  create_table "spina_structure_parts", force: :cascade do |t|
    t.integer  "structure_item_id"
    t.integer  "structure_partable_id"
    t.string   "structure_partable_type"
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id", using: :btree
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id", using: :btree
  end

  create_table "spina_structures", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_text_translations", force: :cascade do |t|
    t.integer  "spina_text_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "content"
    t.index ["locale"], name: "index_spina_text_translations_on_locale", using: :btree
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id", using: :btree
  end

  create_table "spina_texts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "last_logged_in"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "timeline_comments", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "timeline_step_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["timeline_step_id"], name: "index_timeline_comments_on_timeline_step_id", using: :btree
    t.index ["user_id"], name: "index_timeline_comments_on_user_id", using: :btree
  end

  create_table "timeline_steps", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.text     "entregavel"
    t.date     "entrega"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "check_date"
    t.index ["project_id"], name: "index_timeline_steps_on_project_id", using: :btree
  end

  create_table "user_area_de_interesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "area_de_interesse_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["area_de_interesse_id"], name: "index_user_area_de_interesses_on_area_de_interesse_id", using: :btree
    t.index ["user_id"], name: "index_user_area_de_interesses_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "universidade"
    t.string   "semestre"
    t.text     "about"
    t.string   "linkedin"
    t.string   "phone"
    t.string   "city"
    t.string   "profilepicurl"
    t.string   "nome_empresa"
    t.string   "logourl"
    t.string   "curso"
    t.boolean  "admin",                  default: false
    t.string   "cpf"
    t.string   "telefone"
    t.string   "endereco"
    t.string   "numero"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "uf"
    t.string   "cep"
    t.integer  "tipo_pessoa"
    t.string   "stripe_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "client_solicitations", "projects"
  add_foreign_key "client_solicitations", "users"
  add_foreign_key "invite_emails", "projects"
  add_foreign_key "invite_emails", "users"
  add_foreign_key "member_solicitations", "projects"
  add_foreign_key "member_solicitations", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "payments", "projects"
  add_foreign_key "payments", "users"
  add_foreign_key "project_area_de_interesses", "area_de_interesses", column: "area_de_interesse_id"
  add_foreign_key "project_area_de_interesses", "projects"
  add_foreign_key "project_events", "projects"
  add_foreign_key "project_events", "users"
  add_foreign_key "project_invitations", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "timeline_comments", "timeline_steps"
  add_foreign_key "timeline_comments", "users"
  add_foreign_key "timeline_steps", "projects"
  add_foreign_key "user_area_de_interesses", "area_de_interesses", column: "area_de_interesse_id"
  add_foreign_key "user_area_de_interesses", "users"
end
