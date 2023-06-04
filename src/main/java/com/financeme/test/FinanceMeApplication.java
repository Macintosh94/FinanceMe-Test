package com.financeme.test;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class FinanceMeApplication {
	
    public static void main( String[] args ) throws InterruptedException, IOException
    
    {
    	//System.setProperty("webdriver.chrome.driver", "D:\\Project\\Banking\\test\\test\\chromedriver.exe");
    	System.setProperty("webdriver.chrome.driver", "/usr/bin/chromedriver");
    	ChromeOptions chromeoptions = new ChromeOptions();
    	chromeoptions.addArguments("--headless=new");
    	chromeoptions.addArguments("--remote-allow-origins=*");
    	WebDriver driver = new ChromeDriver(chromeoptions);
    	
    	System.out.println("Selenium test script has started...");
    	
    	//driver.get("http://10.0.128.6:8081/contact.html");
    	driver.get("http://localhost:8081/contact.html");
    	Thread.sleep(2000);
    	driver.findElement(By.name("Name")).sendKeys("Palash");
    	driver.findElement(By.name("Phone Number")).sendKeys("82732819");
    	driver.findElement(By.name("Email")).sendKeys("Palash@gmail.com");
    	driver.findElement(By.name("Message")).sendKeys("I would like to open an account..");
    	
    	driver.findElement(By.xpath("//div[@class='send_bt']//a[1]")).click();
    	
    	String successMessage = driver.findElement(By.id("message")).getText();
    	String expectedMessage = "Email Sent";
    	assert successMessage.equals(expectedMessage) : "Success message is incorrect" + successMessage;
    	
    	Thread.sleep(2000);
    	TakesScreenshot scrShot = ((TakesScreenshot)driver);
    	
    	File srcFile = scrShot.getScreenshotAs(OutputType.FILE);
    	
    	//File destFile = new File ("D:\\Project\\Banking\\test\\test\\artifact.png");
    	File destFile = new File ("/home/ubuntu/test-artifact/artifact.png");
    	FileUtils.copyFile(srcFile, destFile);
    	
    	driver.quit();
    	
    	System.out.println(" Scripts executed successfully");
    	
    	
    	
    	
    }
}
