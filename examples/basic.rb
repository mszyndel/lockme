# Find a reservation using an ID from LockMe. Returns an instance of Lockme::Reservation
Lockme::Reservation.find(lockme_id)

# Provide a hash of attributes expected by LockMe API
def to_lockme_hash
  {
    reservationid: lockme_id,
    roomid: room_id,
    date: start_at.strftime("%Y-%m-%d"),
    hour: start_at.strftime("%H:%M:%S"),
    people: 4,
    pricer: '1',
    price: '%.2f' % BigDecimal.new(price),
    name: first_name,
    surname: last_name,
    email: email,
    phone: phone,
    comment: nil,
    extid: id.to_s
  }.compact
end

# Save or update a reservation. Returns an instance of Lockme::Reservation
Lockme::Reservation.new(to_lockme_hash).save

# Destroy a reservation. Returns `true` on success
Lockme::Reservation.new(reservationid: lockme_id).destroy
