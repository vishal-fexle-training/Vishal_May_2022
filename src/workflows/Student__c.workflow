<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Request_Approved</fullName>
        <description>Request Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Student_Request_Response/Student_Approved</template>
    </alerts>
    <alerts>
        <fullName>Request_Rejected</fullName>
        <description>Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Student_Request_Response/Student_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Approvers</fullName>
        <description>Send Email to Approvers</description>
        <protected>false</protected>
        <recipients>
            <recipient>Student_Approvers</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Student_Request_Response/Student_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Stage_Completed</fullName>
        <field>Stage__c</field>
        <literalValue>Completed</literalValue>
        <name>Update Stage Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_In_Set_up</fullName>
        <field>Stage__c</field>
        <literalValue>In Set up</literalValue>
        <name>Update Stage In Set up</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_In_progress</fullName>
        <field>Stage__c</field>
        <literalValue>In progress</literalValue>
        <name>Update Stage In progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_Approval_Approved</fullName>
        <field>Student_Approval__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Student Approval Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_Approval_Pending_Approval</fullName>
        <field>Student_Approval__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Student Approval Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_Approval_Rejected</fullName>
        <field>Student_Approval__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Student Approval Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
