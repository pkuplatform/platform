class Constant
  #1, 2, 3, 4 5 standfor the ?th bit in that bit_area.e.g bit 1 is 1 means rejected, bit 1 + 16 is 1 means like
  # bit 1-8: status field: 1-rejected 2-blocked 3-approving 4-approved
  # bit 9-16: privilege level: 1-admin 2-manager 3-planner 4-member
  # bit 17-24: like: 1-like
  #all the number below is just jokey, it is not corret!
  Rejected  = 1 << 0
  Blocked   = 1 << 1
  Approving = 1 << 2
  Approved  = 1 << 3
  Destroy   = 1 << 4
  Mask      = ~31

  Admin    = 1 << 8
  Manager  = 1 << 9
  Planner  = 1 << 10
  Member   = 1 << 11 

  Like  = 1 << 16
  
  Super = 1 << 30

  #for circle we do like unix 0777 mode. 
  #first 7 for owner.admins, second one for owner.persons, and the last for anybody.

  Read  = 1 << 2 
  Write = 1 << 1
  Delete = 1 << 0
end
