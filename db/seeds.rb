# Seeds are idempotent — safe to run multiple times.

# Users
users_data = [
  { email_address: "admin@boohklub.com", password: "password", first_name: "Admin", last_name: "User",  role: "admin" },
  { email_address: "alice@boohklub.com", password: "password", first_name: "Alice", last_name: "Smith", role: "member" },
  { email_address: "bob@boohklub.com",   password: "password", first_name: "Bob",   last_name: "Jones", role: "member" }
]

users = users_data.map do |attrs|
  User.find_or_create_by!(email_address: attrs[:email_address]) do |u|
    u.password              = attrs[:password]
    u.password_confirmation = attrs[:password]
    u.first_name            = attrs[:first_name]
    u.last_name             = attrs[:last_name]
    u.role                  = attrs[:role]
  end
end

admin, alice, bob = users

# Klubs
booh = Klub.find_or_create_by!(name: "Booh") do |k|
  k.activity_type = "books"
  k.description   = "Our cozy book club. Reading one great book at a time."
end

# Memberships — admin is the klub admin, others are members
Membership.find_or_create_by!(user: admin, klub: booh) { |m| m.role = "admin" }
Membership.find_or_create_by!(user: alice, klub: booh) { |m| m.role = "member" }
Membership.find_or_create_by!(user: bob,   klub: booh) { |m| m.role = "member" }

puts "Seeded #{User.count} users, #{Klub.count} klubs, #{Membership.count} memberships."
