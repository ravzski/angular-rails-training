def save_ob obj
  if obj.save
  else
    puts "ERROR >>>>>>> #{obj.class.name} --> #{obj.errors.full_messages}"
  end
end

User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# NOTE: create initial admin
u = User.find_or_initialize_by(
    email: 'test@test.com'
  )

u.password = 'password'
u.first_name = 'admin'
u.last_name = 'admin'
u.super_admin = true
u.save


if Rails.env == "production"
  Area.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('areas')
  [
    {id: 1, name: "Gate In", code: "gate_in"},
    {id: 2, name: "Gate Out", code: "gate_out"},
    {id: 3, name: "Parking", code: "parking"},
    {id: 4, name: "Dock", code: "dock"}
  ].each do |b|
    s = Area.new(id: b[:id], name: b[:name], code: b[:code])
    save_ob(s)
  end

  Stage.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('stages')
  [
    {name: "Initial", code: "initial", area_id: 1, description: 'Initial stage', transition_to_stage: "final"},
    {name: "Final", code: "final", area_id: 2, description: 'Final stage', transition_to_stage: nil}
  ].each do |b|
    s = Stage.new(name: b[:name], code: b[:code], area_id: b[:area_id], description: b[:description], transition_to_stage: b[:transition_to_stage])
    save_ob(s)
  end

  Config.delete_all
  [
    {name: Config::Properties::TotalParkingCount, value: "20"},
    {name: Config::Properties::TimeInGracePeriod, value: "60"}
  ].each do |b|
    s = Config.new(name: b[:name], value: b[:value])
    save_ob(s)
  end
else
  CardType.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('card_types')
  [
    {name: "License", code: "10001", "description": 'License'},
  ].each do |b|
    s = CardType.new(name: b[:name], code: b[:code], description: b[:description])
    save_ob(s)
  end

  Area.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('areas')
  [
    {id: 1, name: "Gate In", code: "gate_in"},
    {id: 2, name: "Gate Out", code: "gate_out"},
    {id: 3, name: "Parking", code: "parking"},
    {id: 4, name: "Dock", code: "dock"}
  ].each do |b|
    s = Area.new(id: b[:id], name: b[:name], code: b[:code])
    save_ob(s)
  end

  Stage.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('stages')
  [
    {name: "Initial", code: "initial", area_id: 1, description: 'Initial stage', transition_to_stage: "final"},
    {name: "Final", code: "final", area_id: 2, description: 'Final stage', transition_to_stage: nil}
  ].each do |b|
    s = Stage.new(name: b[:name], code: b[:code], area_id: b[:area_id], description: b[:description], transition_to_stage: b[:transition_to_stage])
    save_ob(s)
  end

  # NOTE: create initial users
  [
    {email: "ronny_green@becker.org", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "destany_casper@hahnkreiger.net", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "nestor.kihn@hackett.info", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "beulah@pagachalvorson.co", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "ronaldo_blanda@tillmanmurphy.io", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "adaline_parker@cartwright.info", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "madisyn@hartmannmayer.org", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "nova.osinski@moore.com", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "brody_lueilwitz@kutch.net", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "laverne_brakus@ratkejohns.biz", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "gabriella_keeling@dare.net", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "jaeden.beier@dietrich.co", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "leann.murazik@schmitt.co", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "janick@oberbrunnerharvey.biz", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name},
    {email: "emmett_wilkinson@schamberger.co", username: Faker::Name.first_name.downcase, password: 'password', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name}
  ].each do |b|
    u = User.find_or_initialize_by(
          email: b[:email]
        )

    u.password = 'password'
    u.username = b[:username]
    u.first_name = b[:first_name]
    u.last_name = b[:last_name]
    u.super_admin = true
    u.save
  end

  # NOTE: create initial suppliers
  Supplier.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('suppliers')
  [
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name},
    {name: Faker::Name.first_name, company: Faker::Name.first_name}
  ].each do |b|
    s = Supplier.new(name: b[:name], company: b[:company])
    save_ob(s)
  end

  # NOTE: create rfids
  Rfid.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('rfids')
  [
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid},
    {tag: SecureRandom.uuid}
  ].each do |b|
    s = Rfid.new(tag: b[:tag])
    save_ob(s)
  end


  # NOTE: create trucks
  Truck.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('trucks')
  [
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    },
    {
      plate_number: "#{Faker::Name.first_name[0..2].upcase}-#{Faker::Number.number(4)}",
      official_receipt_number: Faker::Number.number(12),
      certificate_number: Faker::Number.number(12),
      make: Faker::Name.first_name,
      model: Faker::Date.between(10.years.ago, Date.current).strftime("%Y"),
      supplier_id: Supplier.all.map(&:id).sample
    }
  ].each_with_index do |b,i|
    s = Truck.new(plate_number: b[:plate_number], official_receipt_number: b[:official_receipt_number], certificate_number: b[:certificate_number], make: b[:make], model: b[:model], supplier_id: b[:supplier_id], rfid_id: Rfid.all.map(&:id)[i])
    save_ob(s)
  end

  # NOTE: create drivers
  Driver.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('drivers')
  [
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name},
    {card_type_id: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, supplier_id: Supplier.all.map(&:id).sample, middle_name: Faker::Name.last_name}
  ].each do |b|
    s = Driver.new(card_type_id: 1, first_name: b[:first_name], last_name: b[:last_name], supplier_id: b[:supplier_id], middle_name: b[:middle_name])
    save_ob(s)
  end

  Assistant.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('assistants')
  [
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {card_type_id: 1, supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name}
  ].each do |b|
    s = Assistant.new(card_type_id: 1, supplier_id: b[:supplier_id], first_name: b[:first_name], last_name: b[:last_name], middle_name: b[:middle_name])
    save_ob(s)
  end

  # NOTE: create coordinators
  Coordinator.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('coordinators')
  [
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name},
    {supplier_id: Supplier.all.map(&:id).sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, middle_name: Faker::Name.last_name}
  ].each do |b|
    s = Coordinator.new(supplier_id: b[:supplier_id], first_name: b[:first_name], last_name: b[:last_name], middle_name: b[:middle_name])
    save_ob(s)
  end

  # NOTE: create RFID Guns
  RfidGun.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('rfid_guns')
  [
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)},
    {code: "#{Faker::Name.first_name[0..2].upcase}#{Faker::Number.number(6)}", serial_no: Faker::Number.number(12)}
  ].each do |b|
    s = RfidGun.new(code: b[:code], serial_no: b[:serial_no])
    save_ob(s)
  end


  BanReason.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('ban_reasons')

  Config.delete_all
  [
    {name: Config::Properties::TotalParkingCount, value: "20"},
    {name: Config::Properties::TimeInGracePeriod, value: "60"}
  ].each do |b|
    s = Config.new(name: b[:name], value: b[:value])
    save_ob(s)
  end
end





# [
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name},
#   {name: Faker::Name.first_name, company: Faker::Name.first_name}
# ].each do |b|
#   Truck.create(name: b[:name], company: b[:company])
# end
