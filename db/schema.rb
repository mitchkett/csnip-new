# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111022014300) do

  create_table "appointments", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "phone"
    t.string   "alternate_phone"
    t.string   "pet_name"
    t.string   "street"
    t.string   "city"
    t.string   "postal_code"
    t.string   "county"
    t.string   "pet_type"
    t.string   "breed"
    t.string   "color"
    t.string   "gender"
    t.text     "surgeries_explanation"
    t.text     "health_concerns_explanation"
    t.text     "medications_explanation"
    t.string   "age"
    t.date     "date_of_birth"
    t.string   "owned_for"
    t.string   "vet_name"
    t.string   "had_litter_when"
    t.integer  "testicle_count"
    t.string   "weight"
    t.boolean  "want_chip_implant"
    t.boolean  "want_rabies_vaccination"
    t.text     "comments"
    t.string   "email"
    t.string   "acquired_from"
    t.string   "best_time_to_contact_client"
    t.string   "pet_vaccinated"
    t.string   "pet_pregnant"
    t.string   "pet_in_heat"
    t.string   "pet_testicles_descended"
    t.string   "has_pet_seen_vet"
    t.string   "where_pet_lives"
    t.boolean  "is_pet_tame"
    t.date     "date_preferred"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
