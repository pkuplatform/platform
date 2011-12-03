class Constant
  #1, 2, 3, 4 standfor the ?th bit in that bit_area.e.g bit 1 is 1 means rejected, bit 1 + 16 is 1 means like
  # bit 1-8: status field: 1-rejected 2-blocked 3-approving 4-approved
  # bit 9-16: privilege level: 1-admin 2-manager 3-planner 4-member
  # bit 17-24: join or like: 1-like 2-join
  #all the number below is just jokey, it is not corret!
  StatusBegin = 1 << 0
  Rejected  = StatusBegin + 0
  Blocked   = StatusBegin + 1
  Approving = StatusBegin + 2
  Approved  = StatusBegin + 3

  PrivilegeBegin = 1 << 8
  Admin    = PrivilegeBegin + 0
  Manager  = PrivilegeBegin + 1
  Member   = PrivilegeBegin + 2
  Planner  = PrivilegeBegin + 3
  
  LikeBegin = 1 << 16
  Like  = LikeBegin + 0
  Join  = LikeBegin + 1
  
end
