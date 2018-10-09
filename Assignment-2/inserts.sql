
   use assignment2_congwen;
  
   #Implement Inserts
   
   #Insert Person
   
   insert into person(id, username, `password`, firstname, lastname, email)
   values(12,'alice','alice','Alice','Wonder','alice@wonder.com'),
		 (23,'bob','bob','Bob','Marley','bob@marley.com'),
		(34,'charlie','charlie','Charles','Garcia','chuch@garcia.com'),
        (45,'dan','dan','Dan','Martin','dan@martin.com'),
        (56,'ed','ed','Ed','Karaz','ed@kar.com');
        
   #insert developer
   
   insert into developer
   values(12,'4321rewq'), (23,'5432trew'), (34, '6543ytre');
   
   #insert user
        
   insert into `user`(id, user_key)
   values(45,'7654fda'), (56,'5678dfgh');
   
   
   
   #Insert Website
   
   insert into website values(123,'Facebook','an online social media and social networking service', curdate(), curdate(),1234234);
   insert into website values(234,'Twitter','an online news and social networking service', curdate(), curdate(),4321543);
   insert into website values(345,'Wikipedia','a free online encyclopedia',curdate(),curdate(), 3456654);
   insert into website values(456,'CNN','an American basic cable and satellite television news channel',curdate(),curdate(),6543345);
   insert into website values(567,'CNET','an American media website that publishes reviews, news, articles, blogs, podcasts and videos on technology and consumer electronics',
                              curdate(),curdate(),5433455);
   insert into website values(678,'Gizmodo','a design, technology, science and science fiction website that also writes articles on politics',
                              curdate(),curdate(),4322345);


   
   
   #Insert website_role
   
   insert into website_role values(null,12,123,'owner');
   insert into website_role values(null,23,123,'editor');
   insert into website_role values(null,34,123,'admin');
   
   insert into website_role values(null,23,234,'owner');
   insert into website_role values(null,34,234,'editor');
   insert into website_role values(null,12,234,'admin');
   
   insert into website_role values(null,34,345,'owner');
   insert into website_role values(null,12,345,'editor');
   insert into website_role values(null,23,345,'admin');
   
   insert into website_role values(null,12,456,'owner');
   insert into website_role values(null,23,456,'editor');
   insert into website_role values(null,34,456,'admin');
   
   insert into website_role values(null,23,567,'owner');
   insert into website_role values(null,34,567,'editor');
   insert into website_role values(null,12,567,'admin');
   
   insert into website_role values(null,34,678,'owner');
   insert into website_role values(null,12,678,'editor');
   insert into website_role values(null,23,678,'admin');
   
   
   
   #Insert Page
   
   insert into `page` values(123,567,'Home','Landing page',curdate(),curdate(),123434);
   insert into `page` values(234,678,'About','Website description',curdate(),curdate(),234545);
   insert into `page` values(345,345,'Contact','Addresses, phones, and contact info',curdate(),curdate(),345656);
   insert into `page` values(456,456,'Preferences','Where users can configure their preferences',curdate(),curdate(),456776);
   insert into `page` values(567,567,'Profile','Users can configure their personal information',curdate(),curdate(),567878);
   
   
   
   #Insert page_role
   
   insert into page_role values(null,12,123,'editor');
   insert into page_role values(null,23,123,'reviewer');
   insert into page_role values(null,34,123,'writer');
   
   insert into page_role values(null,23,234,'editor');
   insert into page_role values(null,34,234,'reviewer');
   insert into page_role values(null,12,234,'writer');
   
   insert into page_role values(null,34,345,'editor');
   insert into page_role values(null,12,345,'reviewer');
   insert into page_role values(null,23,345,'writer');
   
   insert into page_role values(null,12,456,'editor');
   insert into page_role values(null,23,456,'reviewer');
   insert into page_role values(null,34,456,'writer');
   
   insert into page_role values(null,23,567,'editor');
   insert into page_role values(null,34,567,'reviewer');
   insert into page_role values(null,12,567,'writer');
   
   
   
   #Insert Widget
   
   insert into widget (id,`name`,dtype,`text`,`order`,page_id)
   values(123,'head123','heading','Welcome', 0, 123);
   
   insert into widget (id,`name`,dtype,`text`,`order`,page_id, size)
   values(234,'post234','html','<p>Lorem</p>', 0, 234, null);
   
   insert into widget (id,`name`,dtype,`text`,`order`,page_id)
   values(345,'head345','heading','Hi', 1, 345);
   
   insert into widget (id,`name`,dtype,`text`,`order`,page_id, size)
   values(456,'intro456','html','<h1>Hi</h1>', 2, 345, null);
   
   insert into widget (id,`name`,dtype,`text`,`order`, width, height, src, page_id, size)
   values(567,'image345','image', null, 3, 50, 100, '/img/567.png',345,null);
   
   insert into widget (id,`name`,dtype,`text`,`order`, width, height, url, page_id, size)
   values(678,'video456','youtube', null, 0, 400, 300, 'https://youtu.be/h67VX51QXiQ',456, null);
   
   
   
   #Insert Phone
   
   insert into phone(person_id, phone, `primary`) 
   values(12,'123-234-3456',1), (12,'234-345-4566',0), (23,'345-456-5677',1), (34,'321-432-5435',1),
   (34,'432-432-5433',0), (34,'543-543-6544',0);
   
   
   
   #Insert Address
   
   insert into address(person_id, street1, city, zip,`primary`)
   values(12,'123 Adam St.', 'Alton', '01234',1),(12,'234 Birch St.','Boston', '02345',0),(23,'345 Charles St.', 'Chelms', '03455',1),
   (23,'456 Down St.', 'Dalton', '04566',0),(23,'543 East St.', 'Everett', '01112',0),(34,'654 Frank St.', 'Foulton', '04322',1);
