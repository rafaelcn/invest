<?php declare(strict_types=1);

use Invest\Database\Connection;
use Invest\Database\Query;
use PHPUnit\Framework\TestCase;

final class QueryTest extends TestCase {
    
    /**
     * 
     */
    public function testInsert() {
        $q = new Query('CALL P_INSERT_USER("Rafael Campos Nunes", "ranu", "some password", "02086936290", "rcamposnunes@outlook.com", "45999211031", "1996-07-15", "100.00")');
        
        $this->assertEquals($q->execute(), 1);
    }

    /**
     * 
     */
    public function testSelect() {
        $q = new Query('SELECT * FROM TB_USER');
        
        $this->assertEquals($q->execute(), 1);
    }

    /**
     * Tests if the database binds and executes a SQL instruction correctly.
     */
    public function testBindParameters() {
        $q = new Query('SELECT * FROM TB_USER WHERE USER_NAME = :USER AND USER_PASSWORD = :PASS');

        $q->bind(array(':USER' => "ranu",
                       ':PASS' => "some password"));

        $this->assertEquals($q->execute(), 1);

        while ($row = $q->fetch()) {
            print_r($row);
        }
    }
}