$(document).ready(function () {
  // 메인 페이지 캐러셀 이벤트
  $('.carousel').carousel({
    interval: 2000,
  });

  // 회원가입 클릭 모달 팝업
  $('#register').on('click', function (e) {
    $('#modal-register').modal('show');
  });

  // 로그인 클릭 모달 팝업
  $('#login').on('click', function (e) {
    $('#modal-login').modal('show');
  });

  // ID/PW 찾기 클릭 모달 팝업
  $('#findIdPw').on('click', function (e) {
    $('#modal-findIdPw').modal('show');
  });

  // 유저 정보 수정 모달 팝업
  $('#myPage').on('click', function (e) {
    $('#modal-myUserPage').modal('show');
  });

  // 관리자 회원 삭제 모달 팝업
  $('#adminPage').on('click', function (e) {
    $('#modal-myAdminPage').modal('show');
  });
});

/* 회원가입 관련 */
let idChecked = false; // 아이디 중복 확인
let pwChecked = false; // 비밀번호 중복 확인
let userNameChecked = false; // 닉네임 중복 확인
const makeAccountBtn = document.getElementById('makeAccount'); // 계정 생성 활성화

// 회원가입 버튼 활성화
function btnEnable() {
  if (idChecked && userNameChecked && pwChecked) {
    makeAccountBtn.disabled = false;
  }
}

// getInfo 메소드
function getInfo(request) {
  if (request.readyState == 4 && request.status == 200) {
    let info = request.responseText;
    output.textContent = info;

    if (output.textContent.trim() == '사용가능한 아이디입니다') {
      idChecked = true;
      btnEnable();
    } else if (output.textContent.trim() == '사용가능한 닉네임입니다') {
      userNameChecked = true;
      btnEnable();
    }
  }
}

// 아이디 중복 체크
function idValidate() {
  const input = document.getElementById('ID1');
  const output = document.getElementById('checkId');
  const request = new XMLHttpRequest();

  let id = input.value;
  let url = 'idCheck.jsp?id=' + id;

  if (id == null || id == '') {
    alert('아이디 입력은 필수입니다');
  } else if (id.length < 4) {
    alert('아이디는 최소 4글자 이상이어야합니다');
  } else {
    request.open('GET', url, true);
    request.send();
    request.onreadystatechange = getInfo(request);
  }
}

// 닉네임 중복 체크
function userNameValidate() {
  const input = document.getElementById('userName');
  const output = document.getElementById('checkUserName');
  const request = new XMLHttpRequest();

  let userName = input.value;
  let url = 'userNameCheck.jsp?userName=' + userName;

  if (userName == null || userName == '') {
    alert('닉네임 입력은 필수입니다');
  } else if (userName.length < 4) {
    alert('닉네임은 최소 4글자 이상이어야합니다');
  } else {
    request.open('GET', url, true);
    request.send();
    request.onreadystatechange = getInfo(request);
  }
}

// 비밀번호 확인
$(function () {
  $('#alert-success').hide();
  $('#alert-danger').hide();
  $('#PWCheck').keyup(function () {
    let PW1 = $('#PW1').val();
    let PWCheck = $('#PWCheck').val();

    if (PW1 != '' || PWCheck != '') {
      if (PW1 == PWCheck) {
        $('#alert-success').show();
        $('#alert-danger').hide();
        pwChecked = true;
        btnEnable();
      } else {
        $('#alert-success').hide();
        $('#alert-danger').show();
        pwChecked = false;
      }
    }
  });
});

// 회원정보수정 비밀번호 체크

// 우편번호
function find_PostNum() {
  new daum.Postcode({
    oncomplete: function (data) {
      var addr = ''; // 주소 변수
      var extraAddr = ''; // 참고항목 변수

      if (data.userSelectedType === 'R') {
        // 사용자가 도로명 주소를 선택했을 경우
        addr = data.roadAddress;
      } else {
        // 사용자가 지번 주소를 선택했을 경우(J)
        addr = data.jibunAddress;
      }
      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('postNum').value = data.zonecode;
      document.getElementById('address').value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.getElementById('address').focus();
    },
  }).open();
}

// ID 찾기 공백 체크
function idTrimCheck() {
  let name2 = $('#name2').val();
  let phoneNum2 = $('#phoneNum2').val();

  if (name2.trim() == '' || phoneNum2.trim() == '') {
    alert('빈칸 없이 입력해주세요');
    return false;
  } else return true;
}

// PW 찾기 공백 체크
function pwTrimCheck() {
  let ID = $('#ID').val();
  let name3 = $('#name3').val();
  let phoneNum3 = $('#phoneNum3').val();

  if (name3.trim() == '' || phoneNum3.trim() == '' || ID.trim() == '') {
    alert('빈칸 없이 입력해주세요');
    return false;
  } else return true;
}
