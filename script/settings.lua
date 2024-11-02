--[[ Copyright (c) 2017 Optera
 * Part of Logistics Train Network
 * localizes and converts storage runtime settings
 *
 * See LICENSE.md in the project directory for license information.
--]]

message_level = tonumber(settings.storage["ltn-interface-console-level"].value)
message_filter_age = settings.storage["ltn-interface-message-filter-age"].value
message_include_gps = settings.storage["ltn-interface-message-gps"].value
debug_log = settings.storage["ltn-interface-debug-logfile"].value
min_requested = settings.storage["ltn-dispatcher-requester-threshold"].value
min_provided = settings.storage["ltn-dispatcher-provider-threshold"].value
schedule_cc = settings.storage["ltn-dispatcher-schedule-circuit-control"].value
depot_inactivity = settings.storage["ltn-dispatcher-depot-inactivity"].value * 60
stop_timeout = settings.storage["ltn-dispatcher-stop-timeout"].value * 60
condition_stop_timeout = {type = "time", compare_type = "or", ticks = stop_timeout }
delivery_timeout = settings.storage["ltn-dispatcher-delivery-timeout"].value * 60
finish_loading = settings.storage["ltn-dispatcher-finish-loading"].value
requester_delivery_reset = settings.storage["ltn-dispatcher-requester-delivery-reset"].value
dispatcher_enabled = settings.storage["ltn-dispatcher-enabled"].value
dispatcher_updates_per_tick = settings.storage["ltn-dispatcher-updates-per-tick"].value
dispatcher_nth_tick = settings.storage["ltn-dispatcher-nth_tick"].value
if dispatcher_nth_tick > 1 then
  dispatcher_updates_per_tick = 1
end
depot_reset_filters = settings.storage["ltn-depot-reset-filters"].value
depot_fluid_cleaning = settings.storage["ltn-depot-fluid-cleaning"].value
default_network = settings.storage["ltn-stop-default-network"].value
provider_show_existing_cargo = settings.storage["ltn-provider-show-existing-cargo"].value


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if not event then return end
  if event.setting == "ltn-interface-console-level" then
    message_level = tonumber(settings.storage["ltn-interface-console-level"].value)
  end
  if event.setting == "ltn-interface-message-filter-age" then
    message_filter_age = settings.storage["ltn-interface-message-filter-age"].value
  end
  if event.setting == "ltn-interface-message-gps" then
    message_include_gps = settings.storage["ltn-interface-message-gps"].value
  end
  if event.setting == "ltn-interface-debug-logfile" then
    debug_log = settings.storage["ltn-interface-debug-logfile"].value
  end
  if event.setting == "ltn-dispatcher-requester-threshold" then
    min_requested = settings.storage["ltn-dispatcher-requester-threshold"].value
  end
  if event.setting == "ltn-dispatcher-provider-threshold" then
    min_provided = settings.storage["ltn-dispatcher-provider-threshold"].value
  end
  if event.setting == "ltn-dispatcher-schedule-circuit-control" then
    schedule_cc = settings.storage["ltn-dispatcher-schedule-circuit-control"].value
  end
  if event.setting == "ltn-dispatcher-depot-inactivity" then
    depot_inactivity = settings.storage["ltn-dispatcher-depot-inactivity"].value * 60
  end
  if event.setting == "ltn-dispatcher-stop-timeout" then
    stop_timeout = settings.storage["ltn-dispatcher-stop-timeout"].value * 60
    condition_stop_timeout = {type = "time", compare_type = "or", ticks = stop_timeout }
  end
  if event.setting == "ltn-dispatcher-delivery-timeout" then
    delivery_timeout = settings.storage["ltn-dispatcher-delivery-timeout"].value * 60
  end
  if event.setting == "ltn-dispatcher-finish-loading" then
    finish_loading = settings.storage["ltn-dispatcher-finish-loading"].value
  end
  if event.setting == "ltn-dispatcher-requester-delivery-reset" then
    requester_delivery_reset = settings.storage["ltn-dispatcher-requester-delivery-reset"].value
  end
  if event.setting == "ltn-dispatcher-enabled" then
    dispatcher_enabled = settings.storage["ltn-dispatcher-enabled"].value
  end
  if event.setting == "ltn-dispatcher-updates-per-tick" then
    if dispatcher_nth_tick == 1 then
      dispatcher_updates_per_tick = settings.storage["ltn-dispatcher-updates-per-tick"].value
    else
      dispatcher_updates_per_tick = 1
    end
  end
  if event.setting == "ltn-dispatcher-nth_tick" then
    dispatcher_nth_tick = settings.storage["ltn-dispatcher-nth_tick"].value
    if dispatcher_nth_tick == 1 then
      dispatcher_updates_per_tick = settings.storage["ltn-dispatcher-updates-per-tick"].value
    else
      dispatcher_updates_per_tick = 1
    end
    script.on_nth_tick(nil)
    if next(storage.LogisticTrainStops) then
      script.on_nth_tick(dispatcher_nth_tick, OnTick)
    end
  end
  if event.setting == "ltn-depot-reset-filters" then
    depot_reset_filters = settings.storage["ltn-depot-reset-filters"].value
  end
  if event.setting == "ltn-depot-fluid-cleaning" then
    depot_fluid_cleaning = settings.storage["ltn-depot-fluid-cleaning"].value
  end
  if event.setting == "ltn-stop-default-network" then
    default_network = settings.storage["ltn-stop-default-network"].value
  end
  if event.setting == "ltn-provider-show-existing-cargo" then
    provider_show_existing_cargo = settings.storage["ltn-provider-show-existing-cargo"].value
  end
end)