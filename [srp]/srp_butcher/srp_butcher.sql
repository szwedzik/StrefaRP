INSERT INTO `jobs` (`name`, `label`) VALUES
('butcher', 'Rzeznik')
;


INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('butcher',0,'Rzeznik','Pracownik',15,'{"tshirt_1":15,"tshirt_2":0,"torso_1":146,"torso_2":3,"arms":85,"pants_1":90,"pants_2":1,"shoes_1":56,"shoes_2":1,"helmet_1":132,"helmet_2":4,"sex":0}' , '{"tshirt_1":15,"tshirt_2":0,"torso_1":192,"torso_2":3,"arms":71,"pants_1":93,"pants_2":1,"helmet_1":23,"helmet_2":1,"shoes_1":52,"shoes_2":1,"sex":1}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('alive_chicken', 'Zywy Kurczak', 20),
	('slaughtered_chicken', 'Zabity Kurczak', 20),
	('clean_chicken', 'Umyty Kurczak', 20),
	('packaged_chicken', 'Paczka Kurczaka', 100)
;