-- 02 - Buscar Tarefas no Asana

* Method
    * GET
* URL
    * https://app.asana.com/api/1.0/projects/1209042063369420/tasks
* Authentication
    * Predefined Credential Type
* Credential Type
    * Asana API
* Asana API
    * Asana account 2
* Send Query Parameters
    * Habilitado
* Specify Query Parameters
    * Using Fields Below
        * Query Parameters
            * Name
                * opt_fields
            * Value
                * gid,name,completed,completed_at,created_at,modified_at,start_on,due_on, assignee,assignee.gid,assignee.name, memberships,memberships.project,memberships.project.gid, memberships.section,memberships.section.gid,memberships.section.name, custom_fields,custom_fields.gid,custom_fields.name, custom_fields.display_value,custom_fields.number_value, custom_fields.text_value,custom_fields.enum_value
            * Name
                * limit
            * Value
                * 100
* Send Headers
    * Desabilitado
* Send Body
    * Desabilitado
* Options
    * Pagination
        * Pagination Mode
            * Update a Parameter in Each Request
        * Parameters
            * Type
                * Query
            * Name
                * offset
            * Value
                * {{ $response.body.next_page.offset }}
        * Pagination Complete When
            * Other
        * Complete Expression
            * {{ $response.body.next_page === null }}

        * Limit Pages Fetched
            * Desabilitado
        * Interval Between Requests (ms)
            * 0
