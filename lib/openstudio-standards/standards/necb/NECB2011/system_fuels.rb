class SystemFuels
  attr_accessor :name
  attr_accessor :boiler_fueltype
  attr_accessor :baseboard_type
  attr_accessor :mau_type
  attr_accessor :mau_heating_coil_type
  attr_accessor :mau_cooling_type
  attr_accessor :chiller_type
  attr_accessor :heating_coil_type_sys3
  attr_accessor :heating_coil_type_sys4
  attr_accessor :heating_coil_type_sys6
  attr_accessor :necb_reference_hp
  attr_accessor :necb_reference_hp_supp_fuel
  attr_accessor :fan_type
  attr_accessor :swh_fueltype
  attr_accessor :ecm_fueltype
  attr_accessor :shw_fuel  # Add this line

  def set_defaults(standards_data:, primary_heating_fuel:, shw_fuel: 'NECB_Default')
    # Get fuelset for primary heating fuel.
    system_fuel_defaults = standards_data['fuel_type_sets'].detect { |fuel_type_set| fuel_type_set['name'] == primary_heating_fuel }
    raise("fuel_type_sets named #{primary_heating_fuel} not found in fuel_type_sets table.") if system_fuel_defaults.nil?

    # Assign fuel sources for primary heating fuel.
    @name = system_fuel_defaults['name']
    @boiler_fueltype = system_fuel_defaults['boiler_fueltype']
    @baseboard_type = system_fuel_defaults['baseboard_type']
    @mau_type = system_fuel_defaults['mau_type']
    @mau_cooling_type = system_fuel_defaults['mau_cooling_type']
    @chiller_type = system_fuel_defaults['chiller_type']
    @mau_heating_coil_type = system_fuel_defaults['mau_heating_coil_type']
    @heating_coil_type_sys3 = system_fuel_defaults['heating_coil_type_sys3']
    @heating_coil_type_sys4 = system_fuel_defaults['heating_coil_type_sys4']
    @heating_coil_type_sys6 = system_fuel_defaults['heating_coil_type_sys6']
    @necb_reference_hp = system_fuel_defaults['necb_reference_hp']
    @necb_reference_hp_supp_fuel = system_fuel_defaults['necb_reference_hp_supp_fuel']
    @fan_type = system_fuel_defaults['fan_type']
    @swh_fueltype = system_fuel_defaults['swh_fueltype']
    @ecm_fueltype = system_fuel_defaults['ecm_fueltype']

    # Get fuelset for SHW fuel if different from primary heating fuel.
    if shw_fuel != 'NECB_Default'
      shw_fuel_defaults = standards_data['fuel_type_sets'].detect { |fuel_type_set| fuel_type_set['name'] == shw_fuel }
      raise("fuel_type_sets named #{shw_fuel} not found in fuel_type_sets table.") if shw_fuel_defaults.nil?

      # Assign SHW fuel source.
      @shw_fuel = shw_fuel_defaults['swh_fueltype']
    else
      @shw_fuel = @swh_fueltype  # Default to same as SWH fuel type if not specified.
    end
  end
end
