class Constant
  # bit-01: status field: 0-rejected 1-blocked 2-approving 3-approved
  # bit-23: privilege level: 0-admin 1-manager 2-planner 3-member
  # bit-4: join or like: 0-like 1-join
  Rejected = 0
  Blocked = 1
  Approving = 2
  Approved = 3

  Member = 3
  Planner = 7
  Manager = 11
  Admin = 15
  
  Like = 16
  
end
