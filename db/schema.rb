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

ActiveRecord::Schema.define(:version => 20120621223833) do

  create_table "despachos", :force => true do |t|
    t.text     "conteudo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "processo_id"
  end

  create_table "juntadas", :force => true do |t|
    t.string   "tipo"
    t.integer  "processo_principal_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "motivos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "processos", :force => true do |t|
    t.string   "numero_protocolo"
    t.text     "conteudo"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "requerente_id"
    t.integer  "interessado_id"
    t.integer  "setor_origem_id"
    t.integer  "destino_inicial_id"
    t.integer  "tipo_solicitacao_id"
    t.string   "estado"
    t.text     "observacoes"
    t.integer  "motivo_id"
    t.datetime "data_hr_encerramento"
    t.integer  "juntada_id"
  end

  add_index "processos", ["destino_inicial_id"], :name => "index_requerimentos_on_destino_inicial_id"
  add_index "processos", ["interessado_id"], :name => "index_requerimentos_on_interessado_id"
  add_index "processos", ["requerente_id"], :name => "index_requerimentos_on_requerente_id"
  add_index "processos", ["setor_origem_id"], :name => "index_requerimentos_on_setor_origem_id"
  add_index "processos", ["tipo_solicitacao_id"], :name => "index_requerimentos_on_tipo_solicitacao_id"

  create_table "setores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "solicitantes", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipos_solicitacao", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tramitacoes", :force => true do |t|
    t.integer  "setor_origem_id"
    t.integer  "setor_destino_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "processo_id"
    t.datetime "recebida_em"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "usuarios", :force => true do |t|
    t.string   "papel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
