SELECT DATEDIFF(hour, '2017/08/25 07:00', '2017/08/25 12:45') AS DateDiff;



WITH Projetos AS
(
    SELECT
        proj.task_gid,
        MAX(proj.data_abertura_proposta) AS data_abertura_proposta,
        MAX(proj.data_reuniao_abertura) AS data_reuniao_abertura
    FROM dbo.vw_projetos_tratada AS proj
    WHERE 
		proj.data_reuniao_abertura IS NOT NULL
		[[AND proj.data_abertura_proposta >= {{data_inicial}}]]
    GROUP BY
        proj.task_gid
)
SELECT
    AVG(
        CAST(
            DATEDIFF(
                DAY,
                data_abertura_proposta,
                data_reuniao_abertura
            ) AS DECIMAL(10,2)
        )
    ) AS media_dias_reuniao_abertura
FROM Projetos;