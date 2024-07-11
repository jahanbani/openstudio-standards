require 'minitest/autorun'
require 'json'
require 'fileutils'
require_relative '../../../helpers/minitest_helper'
require_relative '../../../helpers/necb_helper'
include NecbHelper

class NECB_SHW_Fuel < Minitest::Test

  def setup
    define_folders(__dir__)
    define_std_ranges
  end

  def test_btap_shw_fuel
    output_folder = method_output_folder(__method__)
    template = 'NECB2011'
    standard = get_standard(template)
    save_intermediate_models = true

    
    building_type = 'FullServiceRestaurant'
    primary_heating_fuel = 'NaturalGas'
    shw_fuel = 'FuelOilNo2'
    epw_file = 'CAN_ON_Toronto.Intl.AP.716240_CWEC2020.epw'

    model = standard.model_create_prototype_model(building_type: building_type,
                                                  epw_file: epw_file,
                                                  template: template,
                                                  primary_heating_fuel: primary_heating_fuel,
                                                  shw_fuel: shw_fuel,
                                                  sizing_run_dir: output_folder)
    
    shw_output = []

    
    water_heaters = model.getWaterHeaterMixeds
    water_heaters.each do |wh|
      shw_output << {
        name: wh.name.get.to_s,
        tankVolume: wh.tankVolume.get.to_f,
        heaterFuelType: wh.heaterFuelType
      }
    end

    
    shw_expected_results = File.join(@expected_results_folder, 'shw_expected_result.json')
    shw_test_results = File.join(@test_results_folder, 'shw_test_result.json')
    unless File.exist?(shw_expected_results)
      puts("No expected results file, creating one based on test results")
      File.write(shw_expected_results, JSON.pretty_generate(shw_output))
    end
    File.write(shw_test_results, JSON.pretty_generate(shw_output))
    msg = "The shw_test_result.json differs from the shw_expected_result.json. Please review the results."
    file_compare(expected_results_file: shw_expected_results, test_results_file: shw_test_results, msg: msg)
  end
end
