# Seeds are idempotent — safe to run multiple times.
[
  { email_address: "admin@boohklub.com", password: "password", first_name: "Admin", last_name: "User", role: "admin" },
  { email_address: "alice@boohklub.com", password: "password", first_name: "Alice", last_name: "Smith", role: "member" },
  { email_address: "bob@boohklub.com",   password: "password", first_name: "Bob",   last_name: "Jones", role: "member" }
].each do |attrs|
  User.find_or_create_by!(email_address: attrs[:email_address]) do |u|
    u.password              = attrs[:password]
    u.password_confirmation = attrs[:password]
    u.first_name            = attrs[:first_name]
    u.last_name             = attrs[:last_name]
  end
end

puts "Seeded #{User.count} users."
