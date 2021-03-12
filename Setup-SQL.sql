/*
CREATE TABLE tablewithxml
(
	id				BIGINT	IDENTITY(1,1) NOT NULL CONSTRAINT pk_id PRIMARY KEY CLUSTERED (id)
	, desc_details	NVARCHAR(255)
	, xmlcol		XML
)
GO
*/

SET NOCOUNT ON
GO

DECLARE @xml XML
SET @xml = '<Root>         
    <ProductDescription ProductID="1" ProductName="Road Bike">         
        <Features>         
        </Features>         
    </ProductDescription>         
</Root>'

INSERT INTO tablewithxml (desc_details, xmlcol)
VALUES (CAST(NEWID() AS NVARCHAR(255)), @xml)
GO 10000

-- SELECT * FROM tablewithxml