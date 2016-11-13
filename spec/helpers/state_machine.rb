def force_state_change(machine, state)
  machine.instance_variable_get(:@storage_adapter).create(nil, state)
end
