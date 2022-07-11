-- hr (비활성화된 사용자)를 해제(사용할 수 있도록)
alter user hr account unlock;

--hr 비밀번호 설정
alter user hr identified by "hr1234";

--hr의 DB권한 설정
grant connect, resource, dba to hr;
