
namespace :permissions do
  task :migrate => :environment do

  ModuleList.delete_all


    ModuleList.create(
      code: "dashboard",
      name: "Dashboard",
      ref_id: "7",
      actions: "read,write")

    ModuleList.create(
      code: "schedule",
      name: "Scheduling",
      ref_id: "8",
      actions: "read,write")

    ModuleList.create(
      code: "transaction",
      name: "Transactions",
      ref_id: "18",
      actions: "read,write")

    ModuleList.create(
      code: "report",
      name: "Reports",
      ref_id: "19",
      actions: "read")

    ModuleList.create(
      code: "user",
      name: "Users",
      ref_id: "1",
      actions: "read,write")

    ModuleList.create(
      code: "driver",
      name: "Drivers",
      ref_id: "2",
      actions: "read,write")

    ModuleList.create(
      code: "assistant",
      name: "Assistant",
      ref_id: "3",
      actions: "read,write")

    ModuleList.create(
      code: "supplier",
      name: "Supplier",
      ref_id: "4",
      actions: "read,write")


    ModuleList.create(
      code: "truck",
      name: "Truck",
      ref_id: "5",
      actions: "read,write")

    ModuleList.create(
      code: "rfid",
      name: "RFID",
      ref_id: "6",
      actions: "read,write")


    ModuleList.create(
      code: "coordinator",
      name: "Coordinators",
      ref_id: "9",
      actions: "read,write")


    ModuleList.create(
      code: "card",
      name: "Cards",
      ref_id: "10",
      actions: "read,write")


    ModuleList.create(
      code: "ban_reason_type",
      name: "Ban Reasons Types",
      ref_id: "11",
      actions: "read,write")

    ModuleList.create(
      code: "ban_reason",
      name: "Ban Reasons",
      ref_id: "11",
      actions: "read,write")

    ModuleList.create(
      code: "area",
      name: "Areas",
      ref_id: "12",
      actions: "read")

    ModuleList.create(
      code: "stage",
      name: "Stages",
      ref_id: "13",
      actions: "read,write")


    ModuleList.create(
      code: "card_type",
      name: "Card Types",
      ref_id: "14",
      actions: "read,write")


    ModuleList.create(
      code: "dock",
      name: "Docks",
      ref_id: "15",
      actions: "read,write")

    ModuleList.create(
      code: "rfid_gun",
      name: "RFID Gun",
      ref_id: "16",
      actions: "read,write")


    ModuleList.create(
      code: "role",
      name: "Roles",
      ref_id: "17",
      actions: "read,write")

    ModuleList.create(
      code: "transactions",
      name: "Transactions",
      ref_id: "18",
      actions: "read,write")

    ModuleList.create(
      code: "reports",
      name: "Reports",
      ref_id: "19",
      actions: "read,write")

    ModuleList.create(
      code: "schedules",
      name: "Schedules",
      ref_id: "20",
      actions: "read,write")

    ModuleList.create(
      code: "contact_type",
      name: "Contact Types",
      ref_id: "21",
      actions: "read,write")

    # Permission::ADMIN.each do |t|
    #   t[:actions].each do |a|
    #     Permission.create(code: t[:code], actions: a, role_code: 'admin')
    #   end
    # end
    #
    #
    # Permission::OPERATOR.each do |t|
    #   t[:actions].each do |a|
    #     Permission.create(code: t[:code], actions: a, role_code: 'operator')
    #   end
    # end
    #
    # Permission::STAFF.each do |t|
    #   t[:actions].each do |a|
    #     Permission.create(code: t[:code], actions: a, role_code: 'staff')
    #   end
    # end

  end
end
