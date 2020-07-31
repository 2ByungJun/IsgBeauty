package egovframework.example.sample.web.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpService;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.example.sample.service.paging.Paging;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class EmpController {

	/** empService */
	@Resource(name = "empService")
	private EmpService empService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 직원 View
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/empList.do")
	public String empList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		System.out.println("[직원 리스트]");

		return "/useLayout/emp/empList";
	}

	@ResponseBody
	@RequestMapping(value = "/empList.json")
     public Map<String, Object> empListJson(@RequestBody EmpVO searchVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		int totCnt = empService.selectEmpListTotCnt(searchVO);

		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		Paging paging = new Paging();
		paging.setCurrentPageNo(searchVO.getPageIndex());
		paging.setRecordCountPerPage(searchVO.getPageUnit());
		paging.setPageSize(searchVO.getPageSize());
		paging.setPageCount((int)Math.ceil(totCnt/10.0));

		searchVO.setFirstIndex(paging.getFirstRecordIndex());
		searchVO.setLastIndex(paging.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paging.getRecordCountPerPage());

		List<EgovMap> empList = empService.selectEmpList(searchVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("pages", paging);
		arrayMap.put("dataList", empList);
		arrayMap.put("datacnt", totCnt);

		return arrayMap;


	}


	/**
	 * 직원 등록 View
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/empRegister.do")
	public String empRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		System.out.println("[직원/관리자 등록]");

		model.addAttribute("empId", request.getAttribute("empId"));

		return "/useLayout/emp/empRegister";
	}

	/**
	 * 직원 상세화면 View
	 *
	 * @param empId
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/empView.do")
	public String empView(@RequestParam("selectedId") String empId,
			@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		System.out.println("[직원 상세화면 페이지]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		model.addAttribute("result", selectEmp(sampleVO, searchVO));

		return "/useLayout/emp/empView";
	}

	/**
	 * 직원 수정 View
	 *
	 * @param empId
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/empEdit.do")
	public String empEdit(@RequestParam("selectedId") String empId,
			@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model, HttpServletRequest request) throws Exception {
		System.out.println("[직원 수정화면]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		model.addAttribute("result", selectEmp(sampleVO, searchVO));
		model.addAttribute("empId", request.getAttribute("empId"));

		return "/useLayout/emp/empEdit";
	}

	/**
	 * 직원 등록
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addEmp.do", method = RequestMethod.POST)
	public String addEmp(@ModelAttribute("searchVO") EmpVO searchVO, EmpVO sampleVO) throws Exception {
		System.out.println("[직원 등록 기능]");

		empService.insertEmp(sampleVO);

		return "forward:/empList.do";
	}

	/**
	 * 관리자 회원가입
	 * @param searchVO
	 * @param snKey
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAdmin.do", method = RequestMethod.POST)
	public String addAdmin(@ModelAttribute("searchVO") EmpVO searchVO, @RequestParam("snKey") String snKey) throws Exception {
		System.out.println("[관리자 등록 기능]");

		searchVO.setCareer("0");
		searchVO.setSalary("0");

		empService.insertEmp(searchVO);

		return "login/login";
	}

	/**
	 * 시리얼 키 확인 (관리자 회원가입용)
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addAdminCheck.json")
     public HashMap<String, Object> snKeyCheck(@RequestBody HashMap<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("[시리얼 키 확인]");
		System.out.println("result============="+ map.get("snKey"));
		String result = empService.snKeyCheck((String) map.get("snKey"));
		System.out.println("result@@@@@@@@@@@@@@@"+ result);

		if(result != null) {
			map.put("result", "true");
		} else {
			map.put("result", "false");
		}

		return map;
	}

	/**
	 * 아이디 중복 확인
	 * @param searchVO
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/IdChecking.json")
     public Map<String, Object> IdChecking(@RequestBody EmpVO searchVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("[아이디 중복 확인]");

		EmpVO empLoginVO = empService.selectEmp(searchVO);
		System.out.println("입력된ID_____________:"+searchVO.getEmpId());

		Map<String, Object> map = new HashMap<>();

		if(empLoginVO != null) {
			map.put("result", "false");
		} else {
			map.put("result", "true");
		}

		return map;
	}

	/**
	 * 직원 조회
	 *
	 * @param sampleVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public EmpVO selectEmp(EmpVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		System.out.println("[직원 조회 기능]");

		return empService.selectEmp(sampleVO);
	}

	/**
	 * 직원 수정
	 *
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateEmp.do", method = RequestMethod.POST)
	public String updateEmp(@ModelAttribute("empVO") EmpVO sampleVO) throws Exception {
		System.out.println("[직원 수정 기능]");

		empService.updateEmp(sampleVO);

		return "forward:/empList.do";
	}

	/**
	 * 직원 삭제
	 *
	 * @param empId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteEmp.do")
	public String deleteEmp(@RequestParam("selectedId") String empId) throws Exception {
		System.out.println("[직원 삭제 기능]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		empService.deleteEmp(sampleVO);

		return "forward:/empList.do";
	}
}
