-- -----------------------------------------------------
-- Seed Data for Vacation Rental Platform
-- Author: Luca Lodola
-- Description: Sample data for testing purposes. 
--              Includes Users, Places, Bookings, Reviews, and Payments.
-- -----------------------------------------------------

USE `vacation_rental_db`;

-- 1. REFERENCE DATA (Countries, Languages, Categories)
-- -----------------------------------------------------

INSERT INTO `countries` (`countryname`, `countrycode`) VALUES
('Italy', 'IT'),
('United States', 'US'),
('Japan', 'JP'),
('France', 'FR'),
('United Kingdom', 'GB');

INSERT INTO `languages` (`languagename`) VALUES
('English'), ('Italian'), ('Japanese'), ('French'), ('Spanish');

INSERT INTO `zipcodes` (`zipcode`, `countryname`) VALUES
('00184', 'Italy'), -- Rome
('10001', 'United States'), -- NYC
('160-0022', 'Japan'), -- Tokyo
('75001', 'France'); -- Paris

INSERT INTO `cities` (`cityname`, `zipcode`) VALUES
('Rome', '00184'),
('New York', '10001'),
('Tokyo', '160-0022'),
('Paris', '75001');

INSERT INTO `streets` (`streetid`, `streetname`, `cityname`) VALUES
(1, 'Via del Colosseo', 'Rome'),
(2, '5th Avenue', 'New York'),
(3, 'Shinjuku Avenue', 'Tokyo'),
(4, 'Rue de Rivoli', 'Paris');

INSERT INTO `placescategories` (`categoryname`, `icon_url`) VALUES
('Apartment', 'https://example.com/icons/apt.png'),
('House', 'https://example.com/icons/house.png'),
('Villa', 'https://example.com/icons/villa.png'),
('Loft', 'https://example.com/icons/loft.png');

INSERT INTO `placestypesnames` (`typename`) VALUES
('Entire Place'),
('Private Room'),
('Shared Room');

INSERT INTO `placestypes` (`typename`, `categoryname`) VALUES
('Entire Place', 'Apartment'),
('Entire Place', 'Villa'),
('Private Room', 'House'),
('Entire Place', 'Loft');

INSERT INTO `placecheckinmethods` (`checkinmethod`) VALUES
('Smart Lock'),
('Keypad'),
('Host Greets You'),
('Lockbox');

INSERT INTO `interestscategories` (`interestname`) VALUES
('Hiking'), ('Museums'), ('Foodie'), ('Photography');

-- 2. USERS AND ADDRESSES
-- -----------------------------------------------------

-- Create Addresses first
INSERT INTO `addresses` (`addressid`, `countryname`, `zipcode`, `cityname`, `streetid`, `housenumber`) VALUES
(1, 'Italy', '00184', 'Rome', 1, '10A'),   -- For Giovanni (Host)
(2, 'United States', '10001', 'New York', 2, '500'), -- For Sarah (Host)
(3, 'Japan', '160-0022', 'Tokyo', 3, '1-1'),  -- For Kenji (Guest)
(4, 'France', '75001', 'Paris', 4, '12');    -- For Amelie (Guest)

-- Create IDs
INSERT INTO `identitycards` (`identitycardid`, `identitycardnumber`, `countryofissue`) VALUES
(1, 'IT12345XYZ', 'Italy'),
(2, 'US98765ABC', 'United States'),
(3, 'JP55555KYO', 'Japan'),
(4, 'FR11122PAR', 'France');

-- Create Users
INSERT INTO `users` (`userid`, `ishost`, `fullname`, `preferredname`, `emailaddress`, `password`, `salt`, `countrycode`, `phonenumber`, `addressid`, `identitycardid`, `intro`, `balance`) VALUES
(1, 1, 'Giovanni Rossi', 'Gio', 'gio@example.com', 'hashed_pass_1', 'salt_123', 'IT', '+393331234567', 1, 1, 'Lover of art and espresso. Hosting in Rome since 2018.', 1500.50),
(2, 1, 'Sarah Smith', 'Sarah', 'sarah@example.com', 'hashed_pass_2', 'salt_456', 'US', '+12125550199', 2, 2, 'Designer living in NYC. I love showing guests the hidden gems.', 2300.00),
(3, 0, 'Kenji Tanaka', 'Ken', 'kenji@example.com', 'hashed_pass_3', 'salt_789', 'JP', '+819012345678', 3, 3, 'Travel photographer looking for inspiration.', 0.00),
(4, 0, 'Amelie Poulain', 'Amy', 'amelie@example.com', 'hashed_pass_4', 'salt_000', 'FR', '+33612345678', 4, 4, 'Exploring the world one city at a time.', 0.00);

-- 3. PLACES (LISTINGS)
-- -----------------------------------------------------

INSERT INTO `places` (`placeid`, `hostid`, `categoryname`, `placetype`, `latitude`, `longitude`, `title`, `description`, `pricepernight`, `checkintime`, `checkouttime`, `directions`, `checkinmethod`, `checkininstructions`, `wifinetworkname`, `wifipassword`, `housemanual`, `checkoutinstructions`) VALUES
(100, 1, 'Loft', 'Entire Place', 41.890251, 12.492373, 'Romantic Colosseum Loft', 'Experience the Dolce Vita in this sun-drenched loft just steps from the Colosseum. High ceilings, vintage decor, and a private terrace.', 120.00, '2023-01-01 15:00:00', '2023-01-01 10:00:00', 'Take Metro B to Colosseo stop.', 'Host Greets You', 'Call me when you arrive.', 'RomaLoft_WiFi', 'PizzaPasta123', 'Please water the plants.', 'Leave keys on the table.'),
(101, 2, 'Apartment', 'Entire Place', 40.712776, -74.005974, 'Modern Midtown Studio', 'Sleek and modern studio in the heart of Manhattan. Walk to Times Square and Central Park.', 250.00, '2023-01-01 16:00:00', '2023-01-01 11:00:00', 'Take Uber to 5th Ave.', 'Keypad', 'Code is 1234#', 'NYC_Guest', 'BigApple2023', 'No parties allowed.', 'Take out the trash.');

-- Place Amenities
INSERT INTO `placeamenities` (`placeamenitiesid`, `placeid`, `wifi`, `tv`, `kitchen`, `airconditioning`, `hottub`) VALUES
(1, 100, 1, 1, 1, 1, 1), -- Rome Loft has everything
(2, 101, 1, 1, 0, 1, 1); -- NYC Studio has no kitchen

-- Place Rules
INSERT INTO `placerules` (`placerulesid`, `placeid`, `smokingallowed`, `eventsallowed`, `quiethours`, `quiethoursbegin`, `quiethoursend`, `additionalrules`) VALUES
(1, 100, 0, 0, 1, '22:00:00', '08:00:00', 'No shoes inside.'),
(2, 101, 0, 0, 1, '23:00:00', '07:00:00', 'Do not buzz neighbors.');

-- 4. TRIPS (BOOKINGS)
-- -----------------------------------------------------

-- Trip 1: Kenji (Japan) visits Giovanni (Rome) - COMPLETED TRIP
INSERT INTO `trips` (`tripid`, `placeid`, `numberofparticipants`, `checkindate`, `checkoutdate`) VALUES
(501, 100, 2, '2023-06-10', '2023-06-15'); 

INSERT INTO `tripsparticipants` (`tripsparticipantid`, `tripid`, `userid`) VALUES
(1, 501, 3); -- Kenji is the main guest

-- Trip 2: Amelie (France) visits Sarah (NYC) - UPCOMING TRIP
INSERT INTO `trips` (`tripid`, `placeid`, `numberofparticipants`, `checkindate`, `checkoutdate`) VALUES
(502, 101, 1, '2024-12-25', '2025-01-01');

INSERT INTO `tripsparticipants` (`tripsparticipantid`, `tripid`, `userid`) VALUES
(2, 502, 4); -- Amelie is the main guest

-- 5. REVIEWS
-- -----------------------------------------------------

-- Kenji reviews the Rome Loft
INSERT INTO `placesreviews` (`reviewid`, `reviewcontent`, `userid`, `tripid`) VALUES
(1, 'Absolutely stunning place! Giovanni was a fantastic host. The view of the Colosseum at sunset is unbeaten.', 3, 501);

-- Giovanni reviews Kenji (Guest Review)
INSERT INTO `guestsreviews` (`reviewid`, `reviewcontent`, `hostid`, `recipient_guestid`) VALUES
(1, 'Kenji was very polite and left the apartment in perfect condition. Highly recommended.', 1, 3);

-- 6. FINANCIALS
-- -----------------------------------------------------

-- Payment for Trip 1 (Rome) - Total 5 nights * 120 = 600
INSERT INTO `payments` (`paymentid`, `tripid`, `userid`, `amount`, `paymentdate`, `paymentmethod`) VALUES
(1, 501, 3, 600.00, '2023-06-01 10:00:00', 'Credit Card');

-- Payout to Giovanni (Host) for Trip 1
INSERT INTO `payouts` (`payoutid`, `tripid`, `userid`, `amount`, `payoutdate`, `status`) VALUES
(1, 501, 1, 570.00, '2023-06-16', 'processed'); -- 570 (minus 30 fee)

-- Payment for Trip 2 (NYC) - Total 7 nights * 250 = 1750
INSERT INTO `payments` (`paymentid`, `tripid`, `userid`, `amount`, `paymentdate`, `paymentmethod`) VALUES
(2, 502, 4, 1750.00, '2024-11-20 14:30:00', 'PayPal');

-- 7. EXTRAS (Wishlists & Messages)
-- -----------------------------------------------------

-- Amelie dreams of Rome too
INSERT INTO `wishlistsnames` (`wishlistid`, `wishlistname`, `userid`) VALUES
(1, 'Summer Vacation', 4);

INSERT INTO `wishlistsitems` (`wishlistitemid`, `placeid`, `wishlistid`) VALUES
(1, 100, 1);

-- Message between Amelie and Sarah regarding NYC trip
INSERT INTO `conversations` (`conversationid`, `tripid`, `creationtime`) VALUES
(1, 502, '2024-11-19 09:00:00');

INSERT INTO `conversationsmessages` (`conversationsmessageid`, `conversationid`, `tripid`, `userid`, `message`, `sendingtime`) VALUES
(1, 1, 502, 4, 'Hi Sarah, is the check-in time flexible?', '2024-11-19 09:05:00'),
(2, 1, 502, 2, 'Hi Amelie! Yes, since you are using the keypad you can arrive anytime after 4PM.', '2024-11-19 09:30:00');