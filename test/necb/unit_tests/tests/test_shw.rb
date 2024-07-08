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
    # Set up remaining parameters for test
    output_folder = method_output_folder(__method__)
    # @expected_results_folder = "#{__dir__}/expected_results"
    template = 'NECB2011'
    standard = get_standard(template)
    save_intermediate_models = true

    # Generate the osm files
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
    
  
    model_name = "#{building_type}-#{shw_fuel}"

    shw_model = model.getWaterHeaterMixeds
    shw_params = shw_model.sort { |obj| standard.water_heater_mixed_apply_efficiency(obj) }
    
    model.getWaterHeaterMixeds


    # begin
    #   diffs = []


    #   expected_osm_file = "#{@expected_results_folder}/#{model_name}_expected_result.osm"
    #   test_osm_file = "#{@expected_results_folder}/#{model_name}_test_result.osm"

    #   #save test results by default
    #   BTAP::FileIO.save_osm(model, test_osm_file)
    #   puts "saved test result osm file to #{test_osm_file}"

    #   # Load the expected osm
    #   unless File.exist?(expected_osm_file)
    #     raise("The initial osm path: #{expected_osm_file} does not exist.")
    #   end
    #   expected_osm_model_path = OpenStudio::Path.new(expected_osm_file.to_s)
    #   # Upgrade version if required.
    #   version_translator = OpenStudio::OSVersion::VersionTranslator.new
    #   expected_model = version_translator.loadModel(expected_osm_model_path).get

    #   # Compare the two models.
    #   diffs = BTAP::FileIO::compare_osm_files(expected_model, model)
    # rescue => exception
    #   # Log error/exception and then keep going.
    #   error = "#{exception.backtrace.first}: #{exception.message} (#{exception.class})"
    #   exception.backtrace.drop(1).map {|s| "\n#{s}"}.each {|bt| error << bt.to_s}
    #   diffs << "#{model_name}: Error \n#{error}"
    # end
    # # Run the simulation
    # standard.model_run_simulation_and_log_errors(model, output_folder)

    # # Create the results file
    # qaqc = standard.init_qaqc(model)
    # qaqc[:os_standards_revision] = "test"
    # qaqc[:os_standards_version] = "test"
    # qaqc[:openstudio_version] = "test"
    # qaqc[:energyplus_version] = "test"
    # btap_data_out = BTAPData.new(model: model,
    #                              runner: nil,
    #                              cost_result: nil,
    #                              qaqc: qaqc,
    #                              npv_start_year: 2010,
    #                              npv_end_year: 2030,
    #                              npv_discount_rate: @npv_discount_rate).btap_data

    # btap_data_out["simulation_btap_data_version"] = "test"
    # btap_data_out["simulation_os_standards_revision"] = "test"
    # btap_data_out["simulation_os_standards_version"] = "test"
    # btap_data_out["simulation_date"] = "test"
    
    # btap_data_expected_results = File.join(@expected_results_folder, 'btap_data_report_expected_result.json')
    # btap_data_test_results = File.join(output_folder, 'btap_data_report_test_result.json')

    # Create expected results file if it does not exist
    # unless File.exist?(btap_data_expected_results)
    #   puts("No expected results file, creating one based on test results")
    #   File.write(btap_data_expected_results, JSON.pretty_generate(btap_data_out))
    # end

    # Save test results

  end

end
