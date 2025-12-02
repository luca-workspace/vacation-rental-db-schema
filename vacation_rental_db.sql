-- -----------------------------------------------------
-- Project: Vacation Rental Platform Database Schema
-- Author: Luca Lodola
-- GitHub: https://github.com/luca-workspace/vacation-rental-db-schema
-- Description: Relational database schema handling users, 
--              properties, bookings, reviews, and payments.
-- -----------------------------------------------------

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vacation_rental_db`
--
CREATE DATABASE IF NOT EXISTS `vacation_rental_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `vacation_rental_db`;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `addressid` int(11) NOT NULL,
  `countryname` varchar(100) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  `cityname` varchar(100) NOT NULL,
  `streetid` int(11) NOT NULL,
  `housenumber` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `cityname` varchar(100) NOT NULL,
  `zipcode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `conversationid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL,
  `creationtime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversationsmessages`
--

CREATE TABLE `conversationsmessages` (
  `conversationsmessageid` int(11) NOT NULL,
  `conversationid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `message` text NOT NULL,
  `sendingtime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversationsparticipants`
--

CREATE TABLE `conversationsparticipants` (
  `conversationid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `joiningtime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `countryname` varchar(100) NOT NULL,
  `countrycode` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `couponid` int(11) NOT NULL,
  `couponcode` varchar(20) NOT NULL,
  `discounttype` enum('percentage','fixed_amount') NOT NULL,
  `discountvalue` decimal(5,2) NOT NULL,
  `minimumpurchase` decimal(10,2) DEFAULT 0.00,
  `maximumdiscount` decimal(10,2) DEFAULT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `usagelimit` int(11) DEFAULT NULL,
  `usedcount` int(11) DEFAULT 0,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emergencycontacts`
--

CREATE TABLE `emergencycontacts` (
  `emergencycontactid` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `relationship` varchar(20) NOT NULL,
  `emailaddress` varchar(100) DEFAULT NULL,
  `countrycode` varchar(5) NOT NULL,
  `phonenumber` varchar(20) NOT NULL,
  `preferredlanguage` varchar(30) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `giftcards`
--

CREATE TABLE `giftcards` (
  `giftcardid` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `recipientname` varchar(50) NOT NULL,
  `recipientemail` varchar(50) NOT NULL,
  `custommessage` varchar(255) DEFAULT NULL,
  `sendername` varchar(50) NOT NULL,
  `sendingdate` date NOT NULL,
  `redeemed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guestsreviews`
--

CREATE TABLE `guestsreviews` (
  `reviewid` int(11) NOT NULL,
  `reviewcontent` varchar(2000) NOT NULL,
  `hostid` int(11) NOT NULL,
  `recipient_guestid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identitycards`
--

CREATE TABLE `identitycards` (
  `identitycardid` int(11) NOT NULL,
  `identitycardnumber` varchar(20) NOT NULL,
  `countryofissue` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `interestscategories`
--

CREATE TABLE `interestscategories` (
  `interestname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `languagename` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `paymentid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paymentdate` datetime NOT NULL,
  `paymentmethod` varchar(20) NOT NULL,
  `couponid` int(11) DEFAULT NULL,
  `coupondiscount` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payouts`
--

CREATE TABLE `payouts` (
  `payoutid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payoutdate` date NOT NULL,
  `status` enum('pending','processed','failed') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placeaccessibilityoptions`
--

CREATE TABLE `placeaccessibilityoptions` (
  `placeaccessibilityoptionsid` int(11) NOT NULL,
  `accessibleparkingspot` tinyint(1) DEFAULT 0,
  `litpathtoguestentrance` tinyint(1) DEFAULT 0,
  `stepfreepathtoguestentrance` tinyint(1) DEFAULT 0,
  `stepfreeguestentrance` tinyint(1) DEFAULT 0,
  `guestentrancewiderthan32inches` tinyint(1) DEFAULT 0,
  `swimmingpoolorhottubhoist` tinyint(1) DEFAULT 0,
  `ceilingormobilehoist` tinyint(1) DEFAULT 0,
  `placeid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placeaccessibilityoptionsimages`
--

CREATE TABLE `placeaccessibilityoptionsimages` (
  `placeaccessibilityoptionsimagesid` int(11) NOT NULL,
  `accessibilityoption` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placeamenities`
--

CREATE TABLE `placeamenities` (
  `placeamenitiesid` int(11) NOT NULL,
  `wifi` tinyint(1) DEFAULT 0,
  `tv` tinyint(1) DEFAULT 0,
  `kitchen` tinyint(1) DEFAULT 0,
  `washer` tinyint(1) DEFAULT 0,
  `freeparking` tinyint(1) DEFAULT 0,
  `paidparking` tinyint(1) DEFAULT 0,
  `airconditioning` tinyint(1) DEFAULT 0,
  `dedicatedworkspace` tinyint(1) DEFAULT 0,
  `pool` tinyint(1) DEFAULT 0,
  `hottub` tinyint(1) DEFAULT 0,
  `patio` tinyint(1) DEFAULT 0,
  `bbqgrill` tinyint(1) DEFAULT 0,
  `outdoordiningarea` tinyint(1) DEFAULT 0,
  `firepit` tinyint(1) DEFAULT 0,
  `pooltable` tinyint(1) DEFAULT 0,
  `indoorfireplace` tinyint(1) DEFAULT 0,
  `piano` tinyint(1) DEFAULT 0,
  `exerciseequipment` tinyint(1) DEFAULT 0,
  `lakeaccess` tinyint(1) DEFAULT 0,
  `beachaccess` tinyint(1) DEFAULT 0,
  `skiinskiout` tinyint(1) DEFAULT 0,
  `outdoorshower` tinyint(1) DEFAULT 0,
  `smokealarm` tinyint(1) DEFAULT 0,
  `firstaidkit` tinyint(1) DEFAULT 0,
  `fireextinguisher` tinyint(1) DEFAULT 0,
  `carbonmonoxidealarm` tinyint(1) DEFAULT 0,
  `placeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placecheckinmethods`
--

CREATE TABLE `placecheckinmethods` (
  `checkinmethod` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placehighlights`
--

CREATE TABLE `placehighlights` (
  `placehighlightsid` int(11) NOT NULL,
  `rare` tinyint(1) DEFAULT 0,
  `rustic` tinyint(1) DEFAULT 0,
  `innature` tinyint(1) DEFAULT 0,
  `memorable` tinyint(1) DEFAULT 0,
  `romantic` tinyint(1) DEFAULT 0,
  `historic` tinyint(1) DEFAULT 0,
  `placeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placerules`
--

CREATE TABLE `placerules` (
  `placerulesid` int(11) NOT NULL,
  `numberofpetsallowed` int(11) NOT NULL DEFAULT 0,
  `eventsallowed` int(11) NOT NULL,
  `smokingallowed` int(11) NOT NULL,
  `quiethours` int(11) NOT NULL,
  `quiethoursbegin` time NOT NULL,
  `quiethoursend` time NOT NULL,
  `additionalrules` varchar(2000) NOT NULL,
  `placeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `places`
--

CREATE TABLE `places` (
  `placeid` int(11) NOT NULL,
  `hostid` int(11) NOT NULL,
  `categoryname` varchar(20) NOT NULL,
  `placetype` varchar(12) NOT NULL,
  `latitude` decimal(8,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(500) NOT NULL,
  `automaticbookingapproval` tinyint(1) NOT NULL DEFAULT 0,
  `soldout` tinyint(1) DEFAULT 0,
  `pricepernight` decimal(10,2) NOT NULL DEFAULT 45.00,
  `checkintime` datetime NOT NULL,
  `checkouttime` datetime NOT NULL,
  `directions` varchar(2000) NOT NULL,
  `checkinmethod` varchar(20) NOT NULL,
  `checkininstructions` varchar(2000) NOT NULL,
  `wifinetworkname` varchar(30) NOT NULL,
  `wifipassword` varchar(30) NOT NULL,
  `housemanual` varchar(2000) NOT NULL,
  `checkoutinstructions` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placescategories`
--

CREATE TABLE `placescategories` (
  `categoryname` varchar(20) NOT NULL,
  `icon_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placesreviews`
--

CREATE TABLE `placesreviews` (
  `reviewid` int(11) NOT NULL,
  `reviewcontent` varchar(2000) NOT NULL,
  `userid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placestypes`
--

CREATE TABLE `placestypes` (
  `typename` varchar(12) NOT NULL,
  `categoryname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placestypesnames`
--

CREATE TABLE `placestypesnames` (
  `typename` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placesunavailabledates`
--

CREATE TABLE `placesunavailabledates` (
  `notavailabledate` date NOT NULL,
  `placeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `redeemedgiftcards`
--

CREATE TABLE `redeemedgiftcards` (
  `giftcardid` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `streets`
--

CREATE TABLE `streets` (
  `streetid` int(11) NOT NULL,
  `streetname` varchar(100) NOT NULL,
  `cityname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `tripid` int(11) NOT NULL,
  `placeid` int(11) NOT NULL,
  `numberofparticipants` int(11) NOT NULL,
  `checkindate` date NOT NULL,
  `checkoutdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tripsparticipants`
--

CREATE TABLE `tripsparticipants` (
  `tripsparticipantid` int(11) NOT NULL,
  `tripid` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `ishost` tinyint(1) DEFAULT 0,
  `fullname` varchar(50) NOT NULL,
  `preferredname` varchar(20) NOT NULL,
  `emailaddress` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `countrycode` varchar(5) NOT NULL,
  `phonenumber` varchar(20) NOT NULL,
  `addressid` int(11) NOT NULL,
  `identitycardid` int(11) NOT NULL,
  `intro` varchar(450) DEFAULT NULL,
  `work` varchar(20) DEFAULT NULL,
  `attendedschool` varchar(40) DEFAULT NULL,
  `showbirthdecade` tinyint(1) DEFAULT 0,
  `showvisitedplaces` tinyint(1) DEFAULT 0,
  `favouritehighschoolsong` varchar(40) DEFAULT NULL,
  `obsessions` varchar(40) DEFAULT NULL,
  `funfact` varchar(40) DEFAULT NULL,
  `mostuselessskill` varchar(40) DEFAULT NULL,
  `bibliographytitle` varchar(40) DEFAULT NULL,
  `excessivetimespenton` varchar(40) DEFAULT NULL,
  `pets` varchar(40) DEFAULT NULL,
  `profilepicture_url` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usersinterests`
--

CREATE TABLE `usersinterests` (
  `userinterestid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `interestname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userslanguages`
--

CREATE TABLE `userslanguages` (
  `userlanguageid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `languagename` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlistsitems`
--

CREATE TABLE `wishlistsitems` (
  `wishlistitemid` int(11) NOT NULL,
  `placeid` int(11) NOT NULL,
  `wishlistid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlistsnames`
--

CREATE TABLE `wishlistsnames` (
  `wishlistid` int(11) NOT NULL,
  `wishlistname` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zipcodes`
--

CREATE TABLE `zipcodes` (
  `zipcode` varchar(10) NOT NULL,
  `countryname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`addressid`),
  ADD KEY `countryname` (`countryname`),
  ADD KEY `zipcode` (`zipcode`),
  ADD KEY `cityname` (`cityname`),
  ADD KEY `streetid` (`streetid`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`cityname`),
  ADD KEY `zipcode` (`zipcode`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`conversationid`),
  ADD KEY `conversations_ibfk_1` (`tripid`);

--
-- Indexes for table `conversationsmessages`
--
ALTER TABLE `conversationsmessages`
  ADD PRIMARY KEY (`conversationsmessageid`),
  ADD KEY `conversationid` (`conversationid`),
  ADD KEY `conversationsmessages_ibfk_2` (`tripid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `conversationsparticipants`
--
ALTER TABLE `conversationsparticipants`
  ADD UNIQUE KEY `conversationid` (`conversationid`,`userid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`countryname`),
  ADD UNIQUE KEY `countrycode` (`countrycode`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`couponid`),
  ADD UNIQUE KEY `couponcode` (`couponcode`);

--
-- Indexes for table `emergencycontacts`
--
ALTER TABLE `emergencycontacts`
  ADD PRIMARY KEY (`emergencycontactid`),
  ADD UNIQUE KEY `emergencycontacts_ibfk_3` (`userid`),
  ADD KEY `preferredlanguage` (`preferredlanguage`),
  ADD KEY `emergencycontacts_ibfk_2` (`countrycode`);

--
-- Indexes for table `giftcards`
--
ALTER TABLE `giftcards`
  ADD PRIMARY KEY (`giftcardid`);

--
-- Indexes for table `guestsreviews`
--
ALTER TABLE `guestsreviews`
  ADD PRIMARY KEY (`reviewid`),
  ADD UNIQUE KEY `hostid` (`hostid`,`recipient_guestid`),
  ADD KEY `recipient_guestid` (`recipient_guestid`);

--
-- Indexes for table `identitycards`
--
ALTER TABLE `identitycards`
  ADD PRIMARY KEY (`identitycardid`),
  ADD UNIQUE KEY `identitycardnumber` (`identitycardnumber`,`countryofissue`),
  ADD KEY `countryofissue` (`countryofissue`);

--
-- Indexes for table `interestscategories`
--
ALTER TABLE `interestscategories`
  ADD PRIMARY KEY (`interestname`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`languagename`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`paymentid`),
  ADD UNIQUE KEY `tripid` (`tripid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `couponid` (`couponid`);

--
-- Indexes for table `payouts`
--
ALTER TABLE `payouts`
  ADD PRIMARY KEY (`payoutid`),
  ADD UNIQUE KEY `tripid` (`tripid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `placeaccessibilityoptions`
--
ALTER TABLE `placeaccessibilityoptions`
  ADD PRIMARY KEY (`placeaccessibilityoptionsid`),
  ADD UNIQUE KEY `placeid` (`placeid`);

--
-- Indexes for table `placeaccessibilityoptionsimages`
--
ALTER TABLE `placeaccessibilityoptionsimages`
  ADD PRIMARY KEY (`placeaccessibilityoptionsimagesid`),
  ADD KEY `accessibilityoption` (`accessibilityoption`);

--
-- Indexes for table `placeamenities`
--
ALTER TABLE `placeamenities`
  ADD PRIMARY KEY (`placeamenitiesid`),
  ADD UNIQUE KEY `amenities_ibfk_1` (`placeid`);

--
-- Indexes for table `placecheckinmethods`
--
ALTER TABLE `placecheckinmethods`
  ADD PRIMARY KEY (`checkinmethod`);

--
-- Indexes for table `placehighlights`
--
ALTER TABLE `placehighlights`
  ADD PRIMARY KEY (`placehighlightsid`),
  ADD UNIQUE KEY `placeid` (`placeid`);

--
-- Indexes for table `placerules`
--
ALTER TABLE `placerules`
  ADD PRIMARY KEY (`placerulesid`),
  ADD UNIQUE KEY `placeid` (`placeid`);

--
-- Indexes for table `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`placeid`),
  ADD KEY `categoryname` (`categoryname`),
  ADD KEY `placetype` (`placetype`),
  ADD KEY `checkinmethod` (`checkinmethod`),
  ADD KEY `hostid` (`hostid`);

--
-- Indexes for table `placescategories`
--
ALTER TABLE `placescategories`
  ADD PRIMARY KEY (`categoryname`);

--
-- Indexes for table `placesreviews`
--
ALTER TABLE `placesreviews`
  ADD PRIMARY KEY (`reviewid`),
  ADD UNIQUE KEY `userid` (`userid`,`tripid`),
  ADD KEY `tripid` (`tripid`);

--
-- Indexes for table `placestypes`
--
ALTER TABLE `placestypes`
  ADD UNIQUE KEY `typename` (`typename`,`categoryname`),
  ADD KEY `categoryname` (`categoryname`);

--
-- Indexes for table `placestypesnames`
--
ALTER TABLE `placestypesnames`
  ADD PRIMARY KEY (`typename`);

--
-- Indexes for table `placesunavailabledates`
--
ALTER TABLE `placesunavailabledates`
  ADD KEY `placeid` (`placeid`);

--
-- Indexes for table `redeemedgiftcards`
--
ALTER TABLE `redeemedgiftcards`
  ADD UNIQUE KEY `giftcardid` (`giftcardid`,`userid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `streets`
--
ALTER TABLE `streets`
  ADD PRIMARY KEY (`streetid`) USING BTREE,
  ADD KEY `cityname` (`cityname`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`tripid`),
  ADD KEY `placeid` (`placeid`);

--
-- Indexes for table `tripsparticipants`
--
ALTER TABLE `tripsparticipants`
  ADD PRIMARY KEY (`tripsparticipantid`),
  ADD UNIQUE KEY `tripid` (`tripid`,`userid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `users_ibfk_3` (`identitycardid`),
  ADD KEY `users_ibfk_1` (`countrycode`),
  ADD KEY `users_ibfk_2` (`addressid`);

--
-- Indexes for table `usersinterests`
--
ALTER TABLE `usersinterests`
  ADD PRIMARY KEY (`userinterestid`),
  ADD UNIQUE KEY `userid` (`userid`,`interestname`),
  ADD KEY `interestname` (`interestname`);

--
-- Indexes for table `userslanguages`
--
ALTER TABLE `userslanguages`
  ADD PRIMARY KEY (`userlanguageid`),
  ADD UNIQUE KEY `userid` (`userid`,`languagename`),
  ADD KEY `languagename` (`languagename`);

--
-- Indexes for table `wishlistsitems`
--
ALTER TABLE `wishlistsitems`
  ADD PRIMARY KEY (`wishlistitemid`),
  ADD UNIQUE KEY `placeid` (`placeid`,`wishlistid`),
  ADD KEY `wishlistid` (`wishlistid`);

--
-- Indexes for table `wishlistsnames`
--
ALTER TABLE `wishlistsnames`
  ADD PRIMARY KEY (`wishlistid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `zipcodes`
--
ALTER TABLE `zipcodes`
  ADD PRIMARY KEY (`zipcode`),
  ADD KEY `countryname` (`countryname`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`countryname`) REFERENCES `countries` (`countryname`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`zipcode`) REFERENCES `zipcodes` (`zipcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_3` FOREIGN KEY (`cityname`) REFERENCES `cities` (`cityname`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_4` FOREIGN KEY (`streetid`) REFERENCES `streets` (`streetid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`zipcode`) REFERENCES `zipcodes` (`zipcode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversationsmessages`
--
ALTER TABLE `conversationsmessages`
  ADD CONSTRAINT `conversationsmessages_ibfk_1` FOREIGN KEY (`conversationid`) REFERENCES `conversations` (`conversationid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversationsmessages_ibfk_2` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversationsmessages_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversationsparticipants`
--
ALTER TABLE `conversationsparticipants`
  ADD CONSTRAINT `conversationsparticipants_ibfk_1` FOREIGN KEY (`conversationid`) REFERENCES `conversations` (`conversationid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversationsparticipants_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `emergencycontacts`
--
ALTER TABLE `emergencycontacts`
  ADD CONSTRAINT `emergencycontacts_ibfk_1` FOREIGN KEY (`preferredlanguage`) REFERENCES `languages` (`languagename`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emergencycontacts_ibfk_2` FOREIGN KEY (`countrycode`) REFERENCES `countries` (`countrycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emergencycontacts_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `guestsreviews`
--
ALTER TABLE `guestsreviews`
  ADD CONSTRAINT `guestsreviews_ibfk_1` FOREIGN KEY (`hostid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guestsreviews_ibfk_2` FOREIGN KEY (`recipient_guestid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `identitycards`
--
ALTER TABLE `identitycards`
  ADD CONSTRAINT `identitycards_ibfk_1` FOREIGN KEY (`countryofissue`) REFERENCES `countries` (`countryname`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`couponid`) REFERENCES `coupons` (`couponid`);

--
-- Constraints for table `payouts`
--
ALTER TABLE `payouts`
  ADD CONSTRAINT `payouts_ibfk_1` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`),
  ADD CONSTRAINT `payouts_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`);

--
-- Constraints for table `placeaccessibilityoptions`
--
ALTER TABLE `placeaccessibilityoptions`
  ADD CONSTRAINT `placeaccessibilityoptions_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`);

--
-- Constraints for table `placeaccessibilityoptionsimages`
--
ALTER TABLE `placeaccessibilityoptionsimages`
  ADD CONSTRAINT `placeaccessibilityoptionsimages_ibfk_1` FOREIGN KEY (`accessibilityoption`) REFERENCES `placeaccessibilityoptions` (`placeaccessibilityoptionsid`);

--
-- Constraints for table `placeamenities`
--
ALTER TABLE `placeamenities`
  ADD CONSTRAINT `placeamenities_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placehighlights`
--
ALTER TABLE `placehighlights`
  ADD CONSTRAINT `placehighlights_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`);

--
-- Constraints for table `placerules`
--
ALTER TABLE `placerules`
  ADD CONSTRAINT `placerules_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `places_ibfk_1` FOREIGN KEY (`categoryname`) REFERENCES `placescategories` (`categoryname`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `places_ibfk_2` FOREIGN KEY (`placetype`) REFERENCES `placestypesnames` (`typename`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `places_ibfk_3` FOREIGN KEY (`checkinmethod`) REFERENCES `placecheckinmethods` (`checkinmethod`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `places_ibfk_4` FOREIGN KEY (`hostid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placesreviews`
--
ALTER TABLE `placesreviews`
  ADD CONSTRAINT `placesreviews_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `placesreviews_ibfk_2` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placestypes`
--
ALTER TABLE `placestypes`
  ADD CONSTRAINT `placestypes_ibfk_1` FOREIGN KEY (`categoryname`) REFERENCES `placescategories` (`categoryname`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `placestypes_ibfk_2` FOREIGN KEY (`typename`) REFERENCES `placestypesnames` (`typename`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `placesunavailabledates`
--
ALTER TABLE `placesunavailabledates`
  ADD CONSTRAINT `placesunavailabledates_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `redeemedgiftcards`
--
ALTER TABLE `redeemedgiftcards`
  ADD CONSTRAINT `redeemedgiftcards_ibfk_1` FOREIGN KEY (`giftcardid`) REFERENCES `giftcards` (`giftcardid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `redeemedgiftcards_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `streets`
--
ALTER TABLE `streets`
  ADD CONSTRAINT `streets_ibfk_1` FOREIGN KEY (`cityname`) REFERENCES `cities` (`cityname`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `trips_ibfk_2` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`);

--
-- Constraints for table `tripsparticipants`
--
ALTER TABLE `tripsparticipants`
  ADD CONSTRAINT `tripsparticipants_ibfk_1` FOREIGN KEY (`tripid`) REFERENCES `trips` (`tripid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tripsparticipants_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`countrycode`) REFERENCES `countries` (`countrycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`addressid`) REFERENCES `addresses` (`addressid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`identitycardid`) REFERENCES `identitycards` (`identitycardid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usersinterests`
--
ALTER TABLE `usersinterests`
  ADD CONSTRAINT `usersinterests_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usersinterests_ibfk_2` FOREIGN KEY (`interestname`) REFERENCES `interestscategories` (`interestname`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userslanguages`
--
ALTER TABLE `userslanguages`
  ADD CONSTRAINT `userslanguages_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userslanguages_ibfk_2` FOREIGN KEY (`languagename`) REFERENCES `languages` (`languagename`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlistsitems`
--
ALTER TABLE `wishlistsitems`
  ADD CONSTRAINT `wishlistsitems_ibfk_1` FOREIGN KEY (`placeid`) REFERENCES `places` (`placeid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlistsitems_ibfk_2` FOREIGN KEY (`wishlistid`) REFERENCES `wishlistsnames` (`wishlistid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlistsnames`
--
ALTER TABLE `wishlistsnames`
  ADD CONSTRAINT `wishlistsnames_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `zipcodes`
--
ALTER TABLE `zipcodes`
  ADD CONSTRAINT `zipcodes_ibfk_1` FOREIGN KEY (`countryname`) REFERENCES `countries` (`countryname`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
