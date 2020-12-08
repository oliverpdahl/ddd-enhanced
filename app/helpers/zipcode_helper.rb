module ZipcodeHelper

    def getZipcodeAccidentGrowthByQuarterQuery(zipcode)
        sql ='SELECT "Most_Populous".zipcode, 
        EXTRACT(YEAR FROM accident_all.Start_Time)"Year", 
        MOD(EXTRACT(MONTH FROM accident_all.Start_Time),4) + 1 "Quarter", 
        CONCAT(MOD(EXTRACT(MONTH FROM accident_all.Start_Time),4) + 1, CONCAT(\'-\', EXTRACT(YEAR FROM accident_all.Start_Time))) "Qt-Year",
        "Most_Populous".population, ROUND(COUNT(accident_all.ID)/"Most_Populous".population, 8)"Accidents Per Capita" 
        FROM ( SELECT * FROM (SELECT * FROM AREA ORDER BY POPULATION DESC) WHERE ZIPCODE = ' + zipcode.to_s + ' ) 
        "Most_Populous", accident_all WHERE "Most_Populous".zipcode = accident_all.zipcode 
        GROUP BY "Most_Populous".zipcode, EXTRACT(YEAR FROM accident_all.Start_Time), 
        MOD(EXTRACT(MONTH FROM accident_all.Start_Time),4) + 1, "Most_Populous".population ORDER BY EXTRACT(YEAR FROM accident_all.Start_Time), 
        MOD(EXTRACT(MONTH FROM accident_all.Start_Time),4) + 1, "Most_Populous".zipcode'
  
        ActiveRecord::Base.connection.exec_query(sql).to_a
    end

    def getZipCodes()
        sql ='SELECT ZIPCODE "Zipcode"
        FROM (SELECT * FROM AREA ORDER BY POPULATION DESC)'
  
        ActiveRecord::Base.connection.exec_query(sql).to_a
    end

end