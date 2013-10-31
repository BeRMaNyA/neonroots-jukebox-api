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

ActiveRecord::Schema.define(:version => 20131031070747) do

  create_table "bars", :force => true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "name_downcased"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "bars", ["name_downcased"], :name => "index_bars_on_name_downcased", :unique => true
  add_index "bars", ["token"], :name => "index_bars_on_token", :unique => true

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.integer  "price_in_cents"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "songs", ["price_in_cents"], :name => "index_songs_on_price_in_cents"
  add_index "songs", ["title", "artist", "album"], :name => "index_songs_on_title_and_artist_and_album", :unique => true

end
