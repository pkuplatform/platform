class Constant
  # bit 1-8: status field: 0-rejected 1-blocked 2-approving 3-approved
  # bit 9-16: privilege level: 0-admin 1-manager 2-planner 3-member, 4-follower
  # bit 17-24: join or like: 0-like 1-join
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
  Follower = PrivilegeBegin + 4
  
  LikeBegin = 1 << 16
  Like  = LikeBegin + 0
  Join  = LikeBegin + 1
  
end
