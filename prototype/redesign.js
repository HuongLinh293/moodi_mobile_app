(function () {
  const moods=['calm','happy','stressed','sad','anxious','angry','tired','ashamed','grateful','numb'];
  const tones={calm:'mint',happy:'yellow',stressed:'orange',sad:'blue',anxious:'pink',angry:'orange',tired:'gray',ashamed:'soft-yellow',grateful:'yellow',numb:'lavender'};
  const grid=document.querySelector('#emotion-grid');
  moods.forEach(key=>{const b=document.createElement('button');b.className='emotion-choice';b.dataset.mood=key;b.dataset.tone=tones[key];b.innerHTML=faceSVG(key,38)+`<span>${EMO[key].vi}</span>`;grid.appendChild(b)});
  const panel=document.querySelector('.checkin-zone'),face=document.querySelector('#selected-face'),title=document.querySelector('#mood-title'),subtitle=document.querySelector('#mood-subtitle'),status=document.querySelector('#inline-status'),toast=document.querySelector('#toast');
  const copy={calm:['Bình yên.','Có vẻ bạn đang có một khoảng thở.'],happy:['Có điều gì làm bạn vui?','Giữ lại một chút ánh sáng của hôm nay.'],stressed:['Đang hơi quá tải?','Mình có thể bắt đầu bằng một bước rất nhỏ.'],sad:['Một ngày hơi nặng?','Bạn không cần phải đi qua nó một mình.'],anxious:['Có điều gì đang làm bạn lo?','Mình cùng gọi tên nó thật chậm.'],angry:['Có điều gì đang làm bạn tức?','Mình cùng hạ nhiệt trước khi chọn bước tiếp theo.'],tired:['Bạn đang cần nghỉ?','Cơ thể cũng đang cố gắng cùng bạn.'],ashamed:['Có điều gì khiến bạn ngại?','Mình có thể nhìn lại mà không phán xét.'],grateful:['Điều gì đáng được giữ lại?','Một điều nhỏ cũng có thể làm ngày dịu hơn.'],numb:['Mọi thứ đang hơi trống rỗng?','Mình bắt đầu bằng một tín hiệu nhỏ từ cơ thể nhé.']};
  function notify(msg){toast.textContent=msg;toast.classList.add('show');clearTimeout(notify.t);notify.t=setTimeout(()=>toast.classList.remove('show'),2200)}
  function choose(b){document.querySelectorAll('.emotion-choice').forEach(x=>x.classList.toggle('selected',x===b));const m=b.dataset.mood;panel.dataset.tone=b.dataset.tone;face.innerHTML=faceSVG(m,220);title.textContent=copy[m][0];subtitle.textContent=copy[m][1];status.textContent=`${EMO[m].vi} đã được chọn.`}
  grid.addEventListener('click',e=>{const b=e.target.closest('.emotion-choice');if(b)choose(b)});
  document.querySelector('#save-mood').onclick=()=>{const b=document.querySelector('.emotion-choice.selected');if(!b)return notify('Chọn một cảm xúc trước nhé.');status.textContent='Đã mở check-in · chọn cường độ tiếp theo.';notify('Bước tiếp theo: chọn cường độ cảm xúc.')};
  document.querySelector('#pause-button').onclick=()=>notify('Pause Mode sẽ mở ở bước tiếp theo.');
  document.querySelector('#pause-from-checkin').onclick=()=>notify('Pause Mode sẽ mở ở bước tiếp theo.');
  document.querySelector('.profile-button').onclick=()=>notify('Hồ sơ và cài đặt sẽ mở tại đây.');
  document.querySelectorAll('[data-view]').forEach(el=>el.addEventListener('click',()=>{const id=el.dataset.view;document.querySelectorAll('.view').forEach(v=>v.hidden=v.id!==id);document.querySelectorAll('[data-view]').forEach(x=>x.classList.toggle('active',x.dataset.view===id));window.scrollTo({top:0,behavior:'smooth'})}));
  face.innerHTML=faceSVG('happy',220);
}());
