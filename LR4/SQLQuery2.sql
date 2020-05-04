--������ ����
CREATE DATABASE Hotels

--1. ��������� ������� �����
ALTER TABLE booking ADD CONSTRAINT fk_booking_client FOREIGN KEY(id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE room_in_booking
ADD
  CONSTRAINT fk_room_in_booking_room FOREIGN KEY(id_room) REFERENCES room(id_room),
  CONSTRAINT fk_room_in_booking_booking FOREIGN KEY(id_booking) REFERENCES booking(id_booking)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE room
ADD
  CONSTRAINT fk_room_hotel FOREIGN KEY(id_hotel) REFERENCES hotel(id_hotel),
  CONSTRAINT fk_room_room_category FOREIGN KEY(id_room_category) REFERENCES room_category(id_room_category)
ON DELETE CASCADE
ON UPDATE CASCADE

--2. ������ ���������� � �������� ��������� �������, ����������� � ������� ��������� ����� �� 1 ������ 2019�

SELECT name, phone, number, checkin_date, checkout_date
FROM room_in_booking
LEFT JOIN room ON room_in_booking.id_room = room.id_room 
LEFT JOIN booking ON room_in_booking.id_booking = booking.id_booking 
LEFT JOIN client ON booking.id_client = client.id_client
WHERE id_hotel = 1 AND id_room_category = 5 AND (checkin_date = '2019-04-01' OR ( (checkout_date > '2019-04-01') AND (checkin_date < '2019-04-01')))

--3.���� ������ ��������� ������� ���� �������� �� 22 ������.

SELECT *
FROM room
EXCEPT
SELECT room.*
FROM room
LEFT JOIN room_in_booking ON room_in_booking.id_room = room.id_room
WHERE checkin_date <= '2019-04-22' AND checkout_date > '2019-04-22'

--4.���� ���������� ����������� � ��������� ������� �� 23 ����� �� ������ ��������� �������

SELECT name, COUNT(name) AS counter
FROM room
LEFT JOIN room_in_booking ON room_in_booking.id_room = room.id_room
LEFT JOIN room_category ON room_category.id_room_category = room.id_room_category
WHERE room.id_hotel = 1 AND checkin_date <= '2019-03-23' AND checkout_date > '2019-03-23'
GROUP BY name


--5.���� ������ ��������� ����������� �������� �� ���� �������� ��������� �������, ��������� � ������ � ��������� ���� ������

/*SELECT room.id_room, MAX(checkout_date) AS checkout_date
FROM room
LEFT JOIN room_in_booking ON room_in_booking.id_room = room.id_room
LEFT JOIN booking ON booking.id_booking = room_in_booking.id_booking
LEFT JOIN client ON client.id_client = booking.id_client
WHERE id_hotel = 1 AND MONTH(checkout_date) = 4
GROUP BY room.id_room */

SELECT room.id_room, client.name,  number, checkout_max
FROM room
LEFT JOIN (SELECT id_room, MAX(checkout_date) AS checkout_max
FROM room_in_booking
WHERE MONTH(checkout_date) = 4
GROUP BY id_room) AS room_in_booking_max_checkout ON room.id_room = room_in_booking_max_checkout.id_room
LEFT JOIN room_in_booking ON room_in_booking.id_room = room.id_room
LEFT JOIN booking ON booking.id_booking = room_in_booking.id_booking
LEFT JOIN client ON client.id_client = booking.id_client
WHERE id_hotel = 1 AND checkout_date = checkout_max
ORDER BY room.id_room


--6.�������� �� 2 ��� ���� ���������� � ��������� ������� ���� �������� ������ ��������� �������, ������� ���������� 10 ���.

UPDATE room_in_booking
SET checkout_date = DATEADD(day, 2, checkout_date)
FROM room_in_booking
WHERE id_room IN (SELECT room_in_booking.id_room
FROM room
LEFT JOIN room_in_booking ON room_in_booking.id_room = room.id_room
WHERE id_hotel = 1 AND id_room_category = 3 AND checkin_date = '2019-05-10')

 /* 7.����� ��� "��������������" �������� ����������. ���������� ���������: ��
����� ���� ������������ ���� ����� �� ���� ���� ��������� ���, �.�. ������
���������� ���������� �������� � ���� �����. ������ � �������
room_in_booking � id_room_in_booking = 5 � 2154 �������� ��������
������������� ���������, ������� ���������� �����. �������������� ������
������� ������ ��������� ���������� � ���� ������������� �������. */

SELECT*
FROM room_in_booking AS first_room, room_in_booking AS second_room
WHERE
   first_room.id_room = second_room.id_room AND first_room.id_room_in_booking <> second_room.id_room_in_booking AND
   first_room.checkin_date >= second_room.checkin_date AND first_room.checkout_date < second_room.checkout_date 
ORDER BY first_room.id_room_in_booking ASC

--8. ������� ������������ � ����������.

BEGIN TRANSACTION
  INSERT INTO booking
  VALUES ('999', GETDATE())
COMMIT

Select*
FROM booking
ORDER BY id_client DESC

--9. �������� ����������� ������� ��� ���� ������.

CREATE INDEX id_hotel_index
ON hotel (id_hotel);

CREATE INDEX room_in_booking_checkin_date_checkout_date_index
ON room_in_booking (checkin_date, checkout_date);

CREATE INDEX room_in_booking_id_room_id_booking_index
ON room_in_booking (id_room, id_booking);

CREATE INDEX room_id_hotel_id_room_category_index
ON room (id_hotel, id_room_category);

CREATE INDEX room_category_id_room_category_index
ON room_category (id_room_category);
  
CREATE INDEX booking_id_client_index
ON booking (id_client);







