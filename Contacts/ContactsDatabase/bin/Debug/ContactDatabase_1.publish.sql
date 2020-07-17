﻿/*
Deployment script for ContactDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ContactDatabase"
:setvar DefaultFilePrefix "ContactDatabase"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

DELETE FROM dbo.ContactEnumsDetails;
DELETE FROM dbo.ContactEnums;

INSERT INTO dbo.ContactEnums (EnumId, EnumName, EnumCategory, EnumDescription)
values  (1, 'AddressEnum','Contact.Address','Address Enums options')
        ,(2, 'PhoneEnum','Contact.Phone','Phone Enums options')
        ,(3, 'RelationshipEnum','Contact.Person','Relationship Enums options')
        ,(4, 'GenderEnum','Contact.Person','Gender Enums options')
        ;

INSERT INTO dbo.ContactEnumsDetails(EnumId, EnumDetailId, EnumItemName, EnumItemValue, EnumItemType)
values 
        --AddressEnum
        (1, 0, 'Home','0','INT')
        ,(1, 1, 'Work','1','INT')
        ,(1, 2, 'Other','2','INT')

        --PhoneEnum
        ,(2, 0, 'Cell','0','INT')
        ,(2, 1, 'Home','1','INT')
        ,(2, 2, 'Work','2','INT')
        ,(2, 3, 'Other','3','INT')

        --Relationship
        ,(3, 0, 'Self','0','INT')
        ,(3, 1, 'Spouse','1','INT')
        ,(3, 2, 'Son','2','INT')
        ,(3, 3, 'Daughter','3','INT')
        ,(3, 4, 'Father','4','INT')
        ,(3, 5, 'Mother','5','INT')
        ,(3, 6, 'GrandParents','6','INT')
        ,(3, 7, 'GrandFather','7','INT')
        ,(3, 8, 'GrandMother','8','INT')
        ,(3, 9, 'Uncle','9','INT')
        ,(3, 10, 'Aunty','10','INT')
        ,(3, 11, 'Cousine','11','INT')

         --Gender
        ,(4, 0, 'Male','0','INT')
        ,(4, 1, 'Female','1','INT')
        ,(4, 2, 'Other','2','INT')

        ;


GO

GO
PRINT N'Update complete.';


GO
