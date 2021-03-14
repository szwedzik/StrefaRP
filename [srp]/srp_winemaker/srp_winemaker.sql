INSERT INTO `jobs` (`name`, `label`) VALUES
('winemaker', 'Winiarz')
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('winemaker',0,'Winiarz','Pracownik', 15, '{"tshirt_1":15,"tshirt_2":0,"torso_1":42,"torso_2":0,"shoes_1":12,"shoes_2":6,"pants_1":102,"pants_2":0,"arms":11,"helmet_1":7,"helmet_2":2,"sex":0}','{"tshirt_1":15,"tshirt_2":0,"torso_1":80,"torso_2":3,"shoes_1":56,"shoes_2":0,"pants_1":46,"pants_2":0,"arms":2,"helmet_1":4,"helmet_2":1,"sex":1}')
;

INSERT INTO `items` (`name`, `label`) VALUES
	('raisin', 'Kisc Winogron'),
	('jus_raisin', 'Sok Winogronowy'),
	('grand_cru', 'Butelka Dojrzałego Wina'),
	('vine', 'Butelka Wina'),
	('clean_raisin', 'Czyste Winogrono')
;