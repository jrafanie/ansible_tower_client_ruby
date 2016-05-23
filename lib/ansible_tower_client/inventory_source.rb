module AnsibleTowerClient
  class InventorySource < BaseModel
    def self.endpoint
      "inventory_sources".freeze
    end

    def can_update?
      response = api.get("#{related['update']}").body

      updatable = JSON.parse(response)
      updatable['can_update']
    end

    def update
      response = api.post("#{related['update']}").body

      update = JSON.parse(response)
      api.inventory_updates.find(update['inventory_update'])
    end
  end
end