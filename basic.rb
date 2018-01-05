# Find a reservation using an ID from LockMe. Returns an instance of Lockme::Reservation
Lockme::Reservation.find(lockme_id)

# Provide a hash of attributes expected by LockMe API
def to_lockme_hash
  {
    reservationid: self.lockme_id,
    roomid: self.slot.room.lockme_id,
    date: self.slot.start_at.strftime("%Y-%m-%d"),
    hour: self.slot.start_at.strftime("%H:%M:%S"),
    people: 4,
    pricer: '1',
    price: '%.2f' % BigDecimal.new(self.price),
    name: self.first_name,
    surname: self.last_name,
    email: self.email,
    phone: self.phone,
    comment: nil,
    extid: self.id.to_s
  }.compact
end

# Save or update a reservation. Returns an instance of Lockme::Reservation
Lockme::Reservation.new(self.to_lockme_hash).save

# Destroy a reservation. Returns `true` on success
Lockme::Reservation.new(reservationid: self.lockme_id).destroy
